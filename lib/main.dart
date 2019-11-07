import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/screen/initial_splash.dart';
import 'package:Anifrag/screen/login.dart';
import 'package:Anifrag/screen/main_tab.dart';
import 'package:Anifrag/screen/test_cached_image.dart';
import 'package:Anifrag/transition/page_route_blank.dart';
import 'package:Anifrag/widget/category_demo.dart';
import 'package:Anifrag/widget/detail_tabbar.dart';
import 'package:Anifrag/widget/loading_route.dart';
import 'package:Anifrag/widget/story_overview.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));

  runApp(MyApp());
}
