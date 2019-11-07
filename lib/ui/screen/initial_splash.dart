import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

class InitialSplash extends StatefulWidget {
  const InitialSplash();

  @override
  _InitialSplashState createState() => _InitialSplashState();
}

// regular new instance bloc

class _InitialSplashState extends State<InitialSplash> {
  @override
  void initState() {
    // final a = widget.requestingWithValue;
    // final b = widget.requesting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final c = widget.requestingWithValue;
    // final d = widget.requesting;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        child: Center(
            child: Image.asset(
          PathImage.splash,
          height: 200,
          width: 200,
        )),
      ),
    );
  }
}
