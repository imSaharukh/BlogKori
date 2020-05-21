import 'package:blogkori/models/postModel.dart';
import 'package:blogkori/webview.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsPage extends StatelessWidget {
  final Posts post;

  DetailsPage(this.post);

  @override
  Widget build(BuildContext context) {
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
                ClipboardManager.copyToClipBoard(post.link).then((result) {
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
              onPressed: null)
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

_launchUrl(String link, BuildContext context) async {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => MyWebView(
            title: "BlogKori",
            selectedUrl: link,
          )));
}
