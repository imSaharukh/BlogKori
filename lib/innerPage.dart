import 'package:blogkori/models/postModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Container(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              post.title.rendered.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            _getPostImage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(post.date.replaceAll('T', ' ')),
                Text(post.modifiedBy.toString())
              ],
            ),
            Html(
              data: post.content.rendered,
              onLinkTap: (String url) {
                _launchUrl(url);
              },
            )
          ],
        ),
      )),
    );
  }
}

_launchUrl(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Cannot launch $link';
  }
}
