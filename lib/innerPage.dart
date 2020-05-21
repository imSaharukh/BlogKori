import 'package:blogkori/models/postModel.dart';
import 'package:blogkori/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatelessWidget {
  final Posts post;

  DetailsPage(this.post);

  _getPostImage() {
    if (post.featuredMedia == null) {
      return SizedBox(
        height: 10,
      );
    } else {
      return Image.network("https://via.placeholder.com/150");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(37, 170, 226, 1),
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Container(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              post.title.rendered.toString(),
              style: GoogleFonts.raleway(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            // _getPostImage(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(DateFormat.yMMMMEEEEd()
                      .format(DateTime.parse(post.date))),
                  Text(post.modifiedBy.toString())
                ],
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
