import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/screen/test_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screen/detail.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:
          Scaffold(backgroundColor: AppColor.backgroundColor, body: TestTab()),
    );
  }
}
