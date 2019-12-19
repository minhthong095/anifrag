import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/di/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_app.dart';

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: Colors.black.withOpacity(0.4), // Color for Android
  //     statusBarBrightness:
  //         Brightness.dark // Dark == white status bar -- for IOS.
  //     ));
  await ComponentInjector.create();
  runApp(MyApp());
}
