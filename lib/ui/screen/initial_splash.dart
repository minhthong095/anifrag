import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_tab_bar.dart';
import 'no_wifi.dart';

class InitialSplashScreen extends StatelessWidget {
  final BlocInitialSplash blocSplash;

  InitialSplashScreen(this.blocSplash);

  static const String nameRoute = '/';
  @override
  Widget build(BuildContext context) {
    return Provider<BlocInitialSplash>(
      create: (ctx) => blocSplash,
      child: _InitialSplash(),
    );
  }
}

class _InitialSplash extends StatefulWidget {
  @override
  _InitialSplashState createState() => _InitialSplashState();
}

// regular new instance bloc

class _InitialSplashState extends State<_InitialSplash> {
  // AnimationController _controller;
  // Tween roundTween = Tween<double>(begin: 0, end: 100 * pi);
  // Animation _animation;
  bool isVisibleNoWifi = false;

  void _initCallInitData() {
    Provider.of<BlocInitialSplash>(context).init((isSuccess, homepageData) {
      isSuccess
          ? Navigator.of(context).pushNamedAndRemoveUntil(
              MainTabBarScreen.nameRoute, (Route<dynamic> route) => false,
              arguments: MainTabBarScreenArgs(homepageData))
          : _switchNoWifi();
    });
  }

  void _switchNoWifi() {
    setState(() {
      isVisibleNoWifi = !isVisibleNoWifi;
    });
    // widget.bloc.init((isSuccess) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       MainTabBar.nameRoute, (Route<dynamic> route) => false);
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisibleNoWifi) {
      _initCallInitData();
    }
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: isVisibleNoWifi
          ? NoWifi(
              onTryAgainTap: () {
                _switchNoWifi();
              },
            )
          : Center(
              child: Image.asset(
              PathImage.splash,
              height: 200,
              width: 200,
            )),
    );
  }
}
