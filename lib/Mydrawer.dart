import 'package:blogkori/aboutUS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> share() async {
      await FlutterShare.share(
          title: 'BlogKori',
          text: 'BlogKori',
          linkUrl: 'https://blogkori.com/',
          chooserTitle: 'BlogKori');
    }

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        "assets/icon.png",
                        height: 60,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("BlogKori App",
                          style: TextStyle(fontSize: 20.0)),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("v 1.1.1",
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
                        // child: Text(
                        //   "Home",
                        //   style: TextStyle(fontSize: 18.0),
                        // ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                child: AboutUs(),
                                type: PageTransitionType.rightToLeft),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "About ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: share,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Share  ",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Icon(
                                Icons.share,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: _launchURL,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Visit Website  ",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Icon(
                                Icons.open_in_new,
                                size: 18,
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
      ),
    );
  }
}

_launchURL() async {
  const url =
      'https://blogkori.com/?utm_source=blogkori_app&utm_medium=app&utm_campaign=about_screen';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
