import 'package:blogkori/custom/pump.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      Navigator.of(context).pushReplacementNamed("/home");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 170, 226, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          PumpingHeart(
            image: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/icon.png")),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
          SpinKitThreeBounce(
            color: Colors.blue,
            size: 50.0,
          ),
        ],
      ),
    );
  }
}
// Image.asset(
//               "assets/icon.png",
//               height: size.height * 0.70,
//               width: size.width * 0.70,
//             )
