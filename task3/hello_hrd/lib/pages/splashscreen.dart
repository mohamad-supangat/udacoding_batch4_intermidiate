import 'package:flutter/material.dart';

import 'dart:async';
import '../components/components.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wave(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconLogo(),
              SizedBox(height: 80),
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  startSplashScreen() async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(
        '/login',
      );
    });
  }
}
