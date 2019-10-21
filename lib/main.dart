import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/screen/test_arrow.dart';
import 'package:Anifrag/widget/category_demo.dart';
import 'package:Anifrag/widget/detail_tabbar.dart';
import 'package:Anifrag/widget/story_overview.dart';
import 'package:Anifrag/widget/test_stack_scrollview.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screen/detail.dart';
import 'screen/home.dart';

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
      home: Scaffold(backgroundColor: AppColor.backgroundColor, body: Home()),
    );
  }
}
