import 'package:blogkori/models/postModel.dart';
import 'package:blogkori/poststatic.dart';
import 'package:blogkori/webview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class DetailsPage extends StatelessWidget {
  final Posts post;
  final List allPostes;
  DetailsPage(this.post, this.allPostes);
  _launchUrl(String link, BuildContext context) async {
    // allPostes.where((element) => false);
    try {
      Iterable<Posts> links = allPostes.where((posts) => posts.link == link);
      debugPrint(
        "web" + links.first.link,
      );

      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(seconds: 1),
            child: DetailsPage(links.first, allPostes)),
      );
    } catch (e) {
      if (!(link.contains("#"))) {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              duration: Duration(seconds: 1),
              child: MyWebView(
                title: "BlogKori",
                selectedUrl: link,
              )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> share() async {
      await FlutterShare.share(
          title: 'BlogKori',
          text: post.title.rendered,
          linkUrl: post.link,
          chooserTitle: post.title.rendered);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.copy,
                color: Colors.grey,
              ),
              onPressed: () {
                FlutterClipboardManager.copyToClipBoard(post.link)
                    .then((result) {
                  Fluttertoast.showToast(
                      msg: "Link Copied to clipboard",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              }),
          IconButton(
              icon: Icon(
                FontAwesomeIcons.shareAlt,
                color: Colors.grey,
              ),
              onPressed: share)
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Container(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                post.title.rendered.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        height: 1.3)),
              ),
            ),
            // _getPostImage(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "Last Updated on " +
                      DateFormat.yMMMMEEEEd().format(
                        DateTime.parse(post.date),
                      ),
                  style: TextStyle(
                      fontSize: 14, color: Color.fromRGBO(85, 85, 85, 1)),
                ),
              ),
            ),
            Html(
              linkStyle: TextStyle(color: Color.fromRGBO(33, 152, 244, 1)),
              defaultTextStyle: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontSize: 17), height: 1.6),
              data: post.content.rendered,
              onLinkTap: (String url) {
                _launchUrl(url, context);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Center(child: Text("SHARE")),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xff707070)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Center(child: Text("Visit Website")),
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xff707070)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
