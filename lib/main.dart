import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/screen/main_tab.dart';
import 'package:Anifrag/screen/test_lottie.dart';
import 'package:Anifrag/transition/detail_transition.dart';
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Detail.nameRoute:
            return DetailTransition(
                child: Detail(
              arguments: settings.arguments,
            ));
        }

        return null;
        // print("GENERATE ROUTE");
        // return MaterialPageRoute(builder: (context) => TestScreen());
      },
      home: MainTabBar(),
    );
  }
}
