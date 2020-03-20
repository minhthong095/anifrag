import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/main_tab_bar.dart';
import 'package:Anifrag/ui/widget/detail_episode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// TODO: Get rid of all Provider. Avoid using them, instead use
/// constructor to send BLoC arguments
/// for easy track.
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
    return MaterialApp(
      // home: InitialSplashScreen(componentInjector.blocInitialSplashComponent),
      home: TestDetailEpisodeScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {

          ///
          case MainTabBarScreen.nameRoute:
            final maintabArg = settings.arguments as MainTabBarScreenArgs;
            return CupertinoPageRoute(
                builder: (context) => MainTabBarScreen(
                    BlocHome.init(componentInjector.blocHomeComponent,
                        maintabArg.homePageData),
                    componentInjector.blocMainTabbarComponent,
                    componentInjector.blocSearchDetailComponent,
                    componentInjector.blocSearchViewComponent));

          ///
          case DetailScreen.nameRoute:
            final _argument = settings.arguments as DetailScreenArgument;
            final blocDetail = BlocDetail.initWithData(
                componentInjector.blocDetailComponent,
                _argument.movie,
                _argument.tagPrefix,
                _argument.casts);
            return PageRouteBuilder(
                transitionDuration: DetailScreen.durationTransition,
                pageBuilder: (_, __, ___) => DetailScreen(
                    componentInjector.blocHomeComponent, blocDetail));
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
