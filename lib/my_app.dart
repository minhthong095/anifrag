import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/initial_splash.dart';
import 'package:Anifrag/ui/screen/login.dart';
import 'package:Anifrag/ui/screen/main_tab.dart';
import 'package:Anifrag/ui/screen/test_cached_image.dart';
import 'package:Anifrag/ui/transition/page_route_blank.dart';
import 'package:Anifrag/ui/widget/category_demo.dart';
import 'package:Anifrag/ui/widget/detail_tabbar.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:Anifrag/ui/widget/story_overview.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // All PageRoute in onGenerateRout must be declare RouteSetting.
  // All routes must be declare in onGeneratRoute also.
  // settings parameter must be implement.

  final BlocInitialSplash _blocInitialSplash;

  @provide
  MyApp(this._blocInitialSplash);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialSplash(_blocInitialSplash),
      onGenerateRoute: (settings) {
        switch (settings.name) {

          ///
          case Detail.nameRoute:
            final detailArgs = settings.arguments as DetailArguments;

            ///
            return PageRouteBuilder(
                settings: _addName(settings, Detail.nameRoute),
                pageBuilder: (context, animation, secondAnimation) => Detail(
                      arguments: DetailArguments(
                          imagePath: detailArgs.imagePath,
                          tagPrefix: detailArgs.tagPrefix),
                    ));

          ///
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