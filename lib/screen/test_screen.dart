import 'dart:async';

import 'package:Anifrag/widget/loading_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreen createState() => _TestScreen();
}

class _TestScreen extends State<TestScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(LoadingRoute());
                    },
                    child: Center(
                      child: Text('TEST SCREEN'),
                    ),
                  )),
            ),
            CupertinoButton(
              onPressed: () async {
                // Navigator.popUntil(context, (route) {
                //   print('Route ' + route.toString());
                //   return false;
                // });
                // Navigator.of(context).pushNamed(LoadingRoute.nameRoute);
                // await new Future.delayed(const Duration(seconds: 3));
                // Navigator.of(context).popUntil(ModalRoute.withName('/'));
              },
              child: Text('Button'),
            )
          ],
        ),
      );
}
