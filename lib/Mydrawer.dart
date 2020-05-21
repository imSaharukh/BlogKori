import 'package:blogkori/aboutUS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> share() async {
      await FlutterShare.share(
          title: 'Example share',
          text: 'Example share text',
          linkUrl: 'https://flutter.dev/',
          chooserTitle: 'Example Chooser Title');
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 90.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Text("S A Saharukh", style: TextStyle(fontSize: 20.0)),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("visite website",
                          style: TextStyle(color: Colors.black45)))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black12,
              child: Padding(
                padding: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Home",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Audio",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Bookmarks",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Interests",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Divider(),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "Become a member",
                    //     style: TextStyle(fontSize: 18.0, color: Colors.teal),
                    //   ),
                    // ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "New Story",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutUs(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "About US",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: share,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.share),
                            Text(
                              "Share",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
