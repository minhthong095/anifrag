import 'dart:math';

import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/ui/screen/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'login.dart';
import 'no_wifi.dart';

class InitialSplash extends StatefulWidget {
  static const String nameRoute = '/';
  final BlocInitialSplash bloc;

  const InitialSplash(this.bloc);

  @override
  _InitialSplashState createState() => _InitialSplashState();
}

// regular new instance bloc

class _InitialSplashState extends State<InitialSplash> {
  // AnimationController _controller;
  // Tween roundTween = Tween<double>(begin: 0, end: 100 * pi);
  // Animation _animation;
  bool isVisibleNoWifi = false;

  void _initCallInitData() {
    widget.bloc.init((isSuccess) {
      isSuccess
          ? Navigator.of(context).pushNamedAndRemoveUntil(
              MainTabBar.nameRoute, (Route<dynamic> route) => false)
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
    if (!isVisibleNoWifi) _initCallInitData();

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
