import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    // List<AboutPage> aboutPage;
    getAbout() async {
      var response =
          await http.get("https://blogkori.com/wp-json/wp/v2/pages/8357");
      if (response.statusCode == 200) {
        print(response.body);
        var parseddata = jsonDecode(response.body);
        print(parseddata["content"]["rendered"]);
        return parseddata["content"]["rendered"];
      } else {
        return "No Internet";
      }
    }

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Color.fromRGBO(0, 21, 39, 1.0),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text(
              'About',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(color: Colors.white),
                  child: FutureBuilder(
                    future: getAbout(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Html(
                          data: snapshot.data,
                          defaultTextStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(fontSize: 17), height: 1.6),
                        );
                      }
                      return SpinKitThreeBounce(
                        color: Colors.blue,
                        size: 50.0,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                // MaterialButton(
                //   color: Colors.grey.shade200,
                //   padding: const EdgeInsets.all(16.0),
                //   onPressed: () async {
                //     //if (await canLaunch(play)) launch(play);
                //   },
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisSize: MainAxisSize.min,
                //     children: <Widget>[
                //       Row(
                //         children: <Widget>[
                //           Icon(
                //             FontAwesomeIcons.googlePlay,
                //             color: Colors.lightGreen,
                //           ),
                //           const SizedBox(width: 10.0),
                //           Text(
                //             "PlayStore",
                //             style: TextStyle(
                //                 color: Theme.of(context).primaryColor,
                //                 fontSize: 20.0,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 10.0),
                //       Text("Rate us on Play Store"),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20.0),
                // MaterialButton(
                //   color: Color.fromRGBO(239, 239, 239, 1),
                //   padding: const EdgeInsets.all(16.0),
                //   onPressed: () async {
                //     // if(await canLaunch(fb))
                //     //   launch(fb);
                //   },
                //   // child: Column(
                //   //   crossAxisAlignment: CrossAxisAlignment.start,
                //   //   mainAxisSize: MainAxisSize.min,
                //   //   children: <Widget>[
                //   //     Row(
                //   //       children: <Widget>[
                //   //         Icon(
                //   //           FontAwesomeIcons.facebook,
                //   //           color: Colors.blueAccent,
                //   //         ),
                //   //         const SizedBox(width: 10.0),
                //   //         Text(
                //   //           "FaceBook",
                //   //           style: TextStyle(
                //   //               color: Theme.of(context).primaryColor,
                //   //               fontSize: 20.0,
                //   //               fontWeight: FontWeight.bold),
                //   //         ),
                //   //       ],
                //   //     ),
                //   //     const SizedBox(height: 10.0),
                //   //     Text(" To Appreciate us like our page at FaceBook "),
                //   //   ],
                //   // ),
                // ),
                SizedBox(height: 20.0),
                Text(
                  "Developer",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                _buildHeader(),
                const SizedBox(height: 10.0),
                // MaterialButton(
                //   color: Colors.grey.shade200,
                //   onPressed: () {
                //     //launch(privacyUrl);
                //   },
                //   child: Text("Privacy Policy"),
                // )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.grey.shade200,
        onPressed: () => _open("https://saharukh.com"),
        child: Row(
          children: <Widget>[
            Container(
                width: 80.0,
                height: 80.0,
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 35.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://avatars3.githubusercontent.com/u/25554766?s=460&u=f47cbcd77c798f5b238778b3e99bcb9abec6e280&v=4",
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                    ))),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "S A Saharukh",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text("Full Stack App Developer"),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.map,
                      size: 12.0,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Dhaka,Bangladesh",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _open(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }
}
