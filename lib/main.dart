import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/screen/main_tab.dart';
import 'package:Anifrag/screen/test_screen.dart';
import 'package:Anifrag/transition/detail_transition.dart';
import 'package:Anifrag/widget/category_demo.dart';
import 'package:Anifrag/widget/detail_tabbar.dart';
import 'package:Anifrag/widget/loading_route.dart';
import 'package:Anifrag/widget/story_overview.dart';

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
      home: MainTabBar(),
      // routes: {
      //   '/': (context) => MainTabBar(),
      // },
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case Detail.nameRoute:
      //       return DetailTransition(
      //           child: Detail(
      //         arguments: settings.arguments,
      //       ));
      //     case LoadingRoute.nameRoute:
      //       return LoadingRoute();
      //   }

      //   return MaterialPageRoute(
      //       builder: (context) => Scaffold(
      //             body: Center(
      //               child: Container(
      //                 child: Text('YOUR REACH EMPTY PAGE ON MAIN.DART'),
      //               ),
      //             ),
      //           ));
      // },
    );
  }
}
