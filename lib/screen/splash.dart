import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
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
