import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'initial_splash.dart';

class NoWifi extends StatelessWidget {
  static const nameRoute = '/nowifi';

  final VoidCallback onTryAgainTap;

  NoWifi({@required this.onTryAgainTap});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SizedBox.fromSize(
                size: Size(100, 100),
                child: SvgPicture.asset(PathSvg.noWifi),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('No internet connection',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xffEDEDED),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text('Please check your network connection.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff808080),
                  )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 60),
                child: CupertinoButton(
                  // color: Color(0xffd92735),
                  color: AppColor.yellow,
                  onPressed: () {
                    onTryAgainTap();
                  },
                  child: Text('Try again',
                      style: TextStyle(fontSize: 17, color: Colors.black
                          // color: Color(0xffEDEDED),
                          )),
                )),
          ],
        ),
      );
}
