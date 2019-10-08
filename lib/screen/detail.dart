import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/widget/detail_tabbar.dart';

import 'package:Anifrag/widget/comment.dart';
import 'package:Anifrag/widget/detail_tabbar.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:Anifrag/widget/text_percent.dart';
import 'package:Anifrag/widget/text_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Detail extends StatelessWidget {
  static final double _paddingTopImage = 20;
  final double _mergeGap = 30;
  final double _heightImage = 320 + _paddingTopImage;
  static final double paddingContent = 17;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size(
                      double.infinity,
                      _heightImage +
                          _paddingTopImage +
                          MediaQuery.of(context).padding.top -
                          _mergeGap),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                    ),
                  ),
                ),
                _Content()
              ],
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(top: _paddingTopImage),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HeroImage(
                      tag: "DURTY BIT",
                      path: PathImage.casablanca,
                      height: _heightImage,
                      fit: BoxFit.fill,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Padding(
          padding: EdgeInsets.only(
            top: 52,
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Casablanca',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox.fromSize(
                size: Size(0, 7),
              ),
              Text(
                '1942 * 1h 42min',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox.fromSize(
                size: Size(0, 30),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Comment(
                      top: TextStar(
                        fontSize: 25,
                        value: 9,
                      ),
                      comment: '77 857',
                    ),
                  ),
                  Flexible(
                    child: Comment(
                      top: TextPercent(
                        iconPath: PathIcon.smallChart,
                        fontSize: 25,
                        value: 9,
                      ),
                      comment: 'In your taste',
                    ),
                  ),
                  Flexible(
                    child: Comment(
                      top: TextPercent(
                        iconPath: PathIcon.fresh,
                        fontSize: 25,
                        value: 98,
                      ),
                      comment: 'Fresh',
                    ),
                  )
                ],
              ),
              SizedBox.fromSize(
                size: Size(0, 30),
              ),
              SafeArea(
                  top: true,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Detail.paddingContent),
                    child: DetailTabbar(),
                  ),
                )
            ],
          ),
        ),
      );
}
