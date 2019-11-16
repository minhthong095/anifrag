import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/store/live_store.dart';
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
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // All PageRoute in onGenerateRout must be declare RouteSetting.
  // All routes must be declare in onGeneratRoute also.
  // settings parameter must be implement.

  final BlocInitialSplash _blocInitialSplash;
  final BlocHome _blocHome;
  final BlocDetail _blocDetail;

  @provide
  MyApp(this._blocInitialSplash, this._blocHome, this._blocDetail);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: TestCachedImage(),
      home: InitialSplash(_blocInitialSplash),
      // home: MainTabBar(),
      onGenerateRoute: (settings) {
        switch (settings.name) {

          ///
          case MainTabBar.nameRoute:
            return CupertinoPageRoute(
                settings: _addName(settings, MainTabBar.nameRoute),
                builder: (context) => Provider<BlocHome>(
                      builder: (context) => _blocHome,
                      child: MainTabBar(),
                    ));

          ///
          case Login.nameRoute:
            return PageRouteBuilder(
                settings: _addName(settings, Login.nameRoute),
                pageBuilder: (context, animation, secondAnimation) => Login());

          ///
          case Detail.nameRoute:
            final detailArgs = settings.arguments as DetailArguments;
            _blocDetail
              ..movie = detailArgs.movie
              ..tagPrefix = detailArgs.tagPrefix
              ..casts = detailArgs.casts;

            return PageRouteBuilder(
                settings: _addName(settings, Detail.nameRoute),
                pageBuilder: (context, animation, secondAnimation) =>
                    Provider<BlocDetail>(
                      builder: (context) => _blocDetail,
                      child: Detail(),
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
