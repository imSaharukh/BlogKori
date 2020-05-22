import 'package:blogkori/Mydrawer.dart';
import 'package:blogkori/innerPage.dart';
import 'package:blogkori/models/postModel.dart';
import 'package:blogkori/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

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
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashScreen(),

        '/home': (context) => MyHomePage(),
      },
      title: 'BlogKori',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = new ScrollController();
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
        automaticallyImplyLeading: false,
        elevation: 1,
        title: InkWell(
          onTap: () {
            _scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          },
          child: Row(
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
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              iconSize: 30,
              icon: Icon(
                Icons.menu,
                color: Colors.blue,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              }),
        ],
      ),
      endDrawer: MyDrawer(),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: posts.length,
                    itemBuilder: (context, position) {
                      //NewArticle article = NewsHelper.getArticle(position);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 250),
                                type: PageTransitionType.rightToLeft,
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
      bottomNavigationBar: isOffline
          ? Container(
              color: Colors.grey,
              child: Text(
                "Offline Mode",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            )
          : Container(
              height: 0, // This is optional
            ),
      floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesomeIcons.arrowUp),
          onPressed: () {
            _scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          }),
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
                    style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            height: 1.3,
                            color: Color.fromRGBO(51, 51, 51, 1))),
                  ),
                ),
                Html(
                  data: author,
                  defaultTextStyle: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 17), height: 1.6),
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
