import 'dart:ui' as prefix0;

import 'package:Anifrag/config/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestScrolStack extends StatefulWidget {
  @override
  _TestScrollStack createState() => _TestScrollStack();
}

class _TestScrollStack extends State<TestScrolStack> {
  @override
  Widget build(BuildContext context) => ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: BackdropFilter(
                  filter: prefix0.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Image.asset(
                    PathImage.thorRagnarok,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                decoration: BoxDecoration(color: Colors.red, boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(227, 126, 12, 1),
                      offset: Offset(0, 20),
                      blurRadius: 20)
                ]),
                constraints: BoxConstraints.expand(height: 320),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                constraints: BoxConstraints.expand(height: 1000),
              )
            ],
          ),
        ],
      );
}
