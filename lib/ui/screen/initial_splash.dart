import 'dart:math';

import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/ui/screen/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'login.dart';

class InitialSplash extends StatefulWidget {
  final BlocInitialSplash bloc;

  const InitialSplash(this.bloc);

  @override
  _InitialSplashState createState() => _InitialSplashState();
}

// regular new instance bloc

class _InitialSplashState extends State<InitialSplash> {
  int i = 0;
  // AnimationController _controller;
  // Tween roundTween = Tween<double>(begin: 0, end: 100 * pi);
  Animation _animation;

  @override
  void initState() {
    // _controller =
    //     AnimationController(vsync: this, duration: Duration(seconds: 100));
    // _animation = roundTween.animate(_controller);
    // _controller.forward();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // widget.bloc.init(() {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       MainTabBar.nameRouete, (Route<dynamic> route) => false);
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.yellow,
      body: Container(
        child: Center(
            child: InkWell(
                onTap: () {
                  // if (i == 0) {
                  //   i++;
                  //   // widget.bloc.init(() {

                  //   // });
                  // }
                  widget.bloc.init(() {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        MainTabBar.nameRoute, (Route<dynamic> route) => false);
                    // Navigator.of(context).pushNamed(MainTabBar.nameRouete);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => Container(
                    //           color: Colors.green,
                    //         )));
                  });
                },
                // child: AnimatedBuilder(
                //   animation: _controller,
                //   child: Image.asset(
                //     PathImage.splash,
                //     height: 200,
                //     width: 200,
                //   ),
                //   builder: (context, widget) => Transform.rotate(
                //     angle: _animation.value,
                //     child: widget,
                //   ),
                // ))),
                child: Image.asset(
                  PathImage.splash,
                  height: 200,
                  width: 200,
                ))),
      ),
    );
  }
}
