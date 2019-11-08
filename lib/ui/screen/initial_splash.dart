import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

class InitialSplash extends StatefulWidget {
  final BlocInitialSplash bloc;

  const InitialSplash(this.bloc);

  @override
  _InitialSplashState createState() => _InitialSplashState();
}

// regular new instance bloc

class _InitialSplashState extends State<InitialSplash> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    // final c = widget.requestingWithValue;
    // final d = widget.requesting;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        child: Center(
            child: InkWell(
          onTap: () {
            if (i == 0) {
              i++;
              widget.bloc.init();
            }
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
