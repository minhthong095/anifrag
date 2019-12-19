import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/initial_splash.dart';
import 'package:Anifrag/ui/screen/login.dart';
import 'package:Anifrag/ui/screen/main_tab_bar.dart';
import 'package:Anifrag/ui/screen/no_wifi.dart';
import 'package:Anifrag/ui/screen/search_detail.dart';
import 'package:Anifrag/ui/transition/page_route_blank.dart';
import 'package:Anifrag/ui/widget/category_demo.dart';
import 'package:Anifrag/ui/widget/detail_tabbar.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:Anifrag/ui/widget/parallax.dart';
import 'package:Anifrag/ui/widget/search_item.dart';
import 'package:Anifrag/ui/widget/story_overview.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:provider/provider.dart';

@provide
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // All PageRoute in onGenerateRout must be declare RouteSetting.
  // All routes must be declare in onGeneratRoute also.
  // settings parameter must be implement.
  @override
  Widget build(BuildContext context) {
    final responseSearch = ResponseSearch(
      id: 1,
      originalTitle: 'Angel has fallen',
      popularity: 12,
      posterPath:
          'https://image.tmdb.org/t/p/w500/fapXd3v9qTcNBTm39ZC4KUVQDNf.jpg',
      releaseDate: DateTime.now(),
      runtime: 123,
    );

    return MaterialApp(
      home: InitialSplashScreen(),
      // home: SearchDetail(),
      // home: SearchDetail(
      //   onTap: () {},
      // ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // case InitialSplashScreen.nameRoute:
          //   return PageRouteBuilder(
          //       transitionDuration: const Duration(milliseconds: 0),
          //       settings: _addName(settings, InitialSplashScreen.nameRoute),
          //       pageBuilder: (context, ani, secondAni) =>
          //           InitialSplashScreen());

          ///
          case MainTabBarScreen.nameRoute:
            return CupertinoPageRoute(
                settings: _addName(settings, MainTabBarScreen.nameRoute),
                builder: (context) => MainTabBarScreen());

          ///
          case Login.nameRoute:
            return PageRouteBuilder(
                settings: _addName(settings, Login.nameRoute),
                pageBuilder: (context, animation, secondAnimation) => Login());

          ///
          case DetailScreen.nameRoute:
            return PageRouteBuilder(
                transitionDuration: DetailScreen.durationTransition,
                settings: _addName(settings, DetailScreen.nameRoute),
                pageBuilder: (_, __, ___) => DetailScreen(
                      argument: settings.arguments,
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
