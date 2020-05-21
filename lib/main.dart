import 'package:blogkori/Mydrawer.dart';
import 'package:blogkori/innerPage.dart';
import 'package:blogkori/models/postModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'BlogKori',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOffline = false;
  List<Posts> posts = [];
  Future getdata() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // No internet
      setState(() {
        isOffline = true;
      });
      debugPrint("No internet");
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool checkValue = prefs.containsKey('posts');
      if (checkValue) {
        String stringValue = prefs.getString('posts');
        setState(() {
          posts = dataFromJson(stringValue);
        });
      } else {
        debugPrint("No internet no offline data");
      }
    } else {
      debugPrint(" internet");
      var url = "https://blogkori.com/wp-json/wp/v2/posts?per_page=100";
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          posts = dataFromJson(response.body);
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('posts', response.body);
        print(posts);
      }
      setState(() {
        isOffline = false;
      });
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/icon.png',
                height: 35,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BlogKori",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Helping commoners build passive income online",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  })),
        ],
      ),
      endDrawer: MyDrawer(),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                isOffline
                    ? Text("Offline Mode")
                    : Container(color: Colors.white // This is optional
                        ),
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, position) {
                      //NewArticle article = NewsHelper.getArticle(position);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 750),
                                type: PageTransitionType.leftToRight,
                                child: DetailsPage(posts[position], posts)),
                          );
                        },
                        child: BlogCard(
                          title: posts[position].title.rendered,
                          author: posts[position].excerpt.rendered,
                          date: posts[position].modified,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard({
    this.title,
    this.author,
    this.date,
  });

  final String title;
  final String author;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        height: 1.3,
                        color: Color.fromRGBO(51, 51, 51, 1)),
                  ),
                ),
                Html(
                  data: author,
                  defaultTextStyle: TextStyle(fontSize: 17, height: 1.6),
                ),
              ],
            ),
          ),
          Divider(
            height: 5,
          )
        ],
      ),
    );
  }
}
