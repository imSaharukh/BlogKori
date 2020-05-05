import 'package:blogkori/Mydrawer.dart';
import 'package:blogkori/innerPage.dart';
import 'package:blogkori/models/postModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
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
  List<Posts> posts = [];
  Future getdata() async {
    var url = "https://blogkori.com/wp-json/wp/v2/posts";
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        posts = dataFromJson(response.body);
      });

      print(posts);
    }
  }

  wp.WordPress wordPress = wp.WordPress(
    baseUrl: 'https://blogkori.com',
  );

  _fetchPosts() {
    Future<List<wp.Post>> posts = wordPress.fetchPosts(
        postParams: wp.ParamsPostList(
          context: wp.WordPressContext.view,
          pageNum: 1,
          perPage: 10,
        ),
        fetchAuthor: true,
        fetchFeaturedMedia: true,
        fetchComments: true);

    return posts;
  }

  _getPostImage(wp.Post post) {
    if (post.featuredMedia == null) {
      return SizedBox();
    }
    return Image.network(post.featuredMedia.sourceUrl);
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.notifications,
                color: Colors.grey,
              )),
          Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              )),
        ],
      ),
      drawer: MyDrawer(),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, position) {
                //NewArticle article = NewsHelper.getArticle(position);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsPage(posts[position])));
                  },
                  child: BlogCard(
                    title: posts[position].title.rendered,
                    author: posts[position].modifiedBy,
                    date: posts[position].date,
                  ),
                );
              },
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
  final String categoryTitle = "random";
  final String author;
  final String date;
  final String readTime = "5 min";
  final String imageAssetName = "cars.jpg";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0),
                      ),
                      flex: 3,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        child: Image.asset(
                          "assets/" + imageAssetName,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        author,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          date + " . " + readTime,
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.bookmark_border)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
