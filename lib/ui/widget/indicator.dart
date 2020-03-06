import 'dart:io';

import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final double strokeAndroid;

  Indicator({this.strokeAndroid = 4});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
        child: CupertinoActivityIndicator(
          radius: 12,
        ),
      );

    return CircularProgressIndicator(
      strokeWidth: strokeAndroid,
      valueColor: AlwaysStoppedAnimation<Color>(AppColor.yellow),
    );
  }
}
