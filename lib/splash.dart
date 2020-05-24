import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () async {
      Navigator.of(context).pushReplacementNamed("/home");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 170, 226, 1),
      body: Center(
        child: Container(
          height: 100 * .75,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/icon.png")),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
      ),
    );
  }
}
// Image.asset(
//               "assets/icon.png",
//               height: size.height * 0.70,
//               width: size.width * 0.70,
//             )
