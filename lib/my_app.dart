import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/bloc/bloc_search_detail.dart';
import 'package:Anifrag/bloc/bloc_search_view.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/initial_splash.dart';
import 'package:Anifrag/ui/screen/login.dart';
import 'package:Anifrag/ui/screen/main_tab_bar.dart';
import 'package:Anifrag/ui/screen/test_dropdown.dart';
import 'package:Anifrag/ui/widget/custom_shadow_wrap.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:Anifrag/ui/widget/small_arrow_dropdown.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

class MyApp extends StatelessWidget {
  // final MainTabBarScreen mainTabBarScreen;
  // final DetailScreen detailScreen;
  // final InitialSplashScreen initialSplashScreen;

  final ComponentInjector componentInjector;

  MyApp(this.componentInjector);

  // This widget is the root of your application.
  // All PageRoute in onGenerateRout must be declare RouteSetting.
  // All routes must be declare in onGeneratRoute also.
  @override
  Widget build(BuildContext context) {
    // final responseSearch = ResponseSearch(
    //   id: 1,
    //   originalTitle: 'Angel has fallen',
    //   popularity: 12,
    //   posterPath:
    //       'https://image.tmdb.org/t/p/w500/fapXd3v9qTcNBTm39ZC4KUVQDNf.jpg',
    //   releaseDate: DateTime.now(),
    //   runtime: 123,
    // );

    return MaterialApp(
      home: componentInjector.initialSplashScreen,
      // home: TestDropDown(),
      // home: TestScrollWheelDropdown(),
      // home: TestDropDown(),
      // home: TestCustomShadowWrap(),
      // home: SearchDetail(
      //   onTap: () {},
      // ),
      onGenerateRoute: (settings) {
        switch (settings.name) {

          ///
          case MainTabBarScreen.nameRoute:
            return CupertinoPageRoute(
                builder: (context) => componentInjector.mainTabBarScreen);

          ///
          case DetailScreen.nameRoute:
            return PageRouteBuilder(
                transitionDuration: DetailScreen.durationTransition,
                pageBuilder: (_, __, ___) => DetailScreen.argument(
                      detailScreenModule: componentInjector.detailScreen,
                      argument: settings.arguments,
                    ));
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

  // RouteSettings _addName(RouteSettings args, String name) {
  //   return RouteSettings(arguments: args.arguments, name: name);
  // }
}
