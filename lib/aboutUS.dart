import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Color.fromRGBO(0, 21, 39, 1.0),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('About US'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                ),
                const SizedBox(height: 20.0),
                MaterialButton(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () async {
                    //if (await canLaunch(play)) launch(play);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.googlePlay,
                            color: Colors.lightGreen,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "PlayStore",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text("Rate us on Play Store"),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                MaterialButton(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () async {
                    // if(await canLaunch(fb))
                    //   launch(fb);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "FaceBook",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(" To Appreciate us like our page at FaceBook "),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Contributor",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                _buildHeader(),
                const SizedBox(height: 10.0),
                MaterialButton(
                  color: Colors.grey.shade200,
                  onPressed: () {
                    //launch(privacyUrl);
                  },
                  child: Text("Privacy Policy"),
                )
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
                        backgroundImage: NetworkImage(
                            "https://avatars3.githubusercontent.com/u/25554766?s=460&u=f47cbcd77c798f5b238778b3e99bcb9abec6e280&v=4")))),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "S A Saharukh",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text("Full Stack Developer"),
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
                      "Dhaka Bangladesh",
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
