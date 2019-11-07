import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/screen/detail.dart';
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
import 'package:inject/inject.dart';

import 'di/module.dart';

class MyApp extends StatelessWidget {
  final Requesting2 requesting;
  final Requesting2 requestingWithValue;

  @provide
  MyApp(this.requesting, this.requestingWithValue);

  // This widget is the root of your application.
  // All PageRoute in onGenerateRout must be declare RouteSetting.
  // All routes must be declare in onGeneratRoute also.
  // settings parameter must be implement.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialSplash(requesting, requestingWithValue),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Detail.nameRoute:
            final detailArgs = settings.arguments as DetailArguments;
            return PageRouteBuilder(
                settings: _addName(settings, Detail.nameRoute),
                pageBuilder: (context, animation, secondAnimation) => Detail(
                      arguments: DetailArguments(
                          imagePath: detailArgs.imagePath,
                          tagPrefix: detailArgs.tagPrefix),
                    ));
          case LoadingRoute.nameRoute:
            return LoadingRoute();
        }

        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Container(
                      child: Text('YOUR REACH EMPTY PAGE ON MAIN.DART'),
                    ),
                  ),
                ));
      },
    );
  }

  RouteSettings _addName(RouteSettings args, String name) {
    return RouteSettings(arguments: args.arguments, name: name);
  }
}
