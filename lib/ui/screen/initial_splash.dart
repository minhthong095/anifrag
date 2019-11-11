import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/network/requesting.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        child: Center(
            child: InkWell(
          onTap: () {
            widget.bloc.init(() {
              // Navigator.of(context).pushNamed(Login.nameRoute);
            });
          },
          child: Image.asset(
            PathImage.splash,
            height: 200,
            width: 200,
          ),
        )),
      ),
    );
  }
}
