import 'dart:io';

import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(
                left: 10, right: 10, top: Platform.isAndroid ? 15 : 0),
            child: Column(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.search,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: SvgPicture.asset(
                            PathSvg.find,
                            color: Colors.grey,
                            height: 20,
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search...',
                                hintStyle: TextStyle(color: Colors.grey)),
                            style: TextStyle(color: Colors.grey[50]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     color: Colors.red,
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
}
