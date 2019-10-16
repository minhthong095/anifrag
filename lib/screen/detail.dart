import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/widget/detail_tabbar.dart';

import 'package:Anifrag/widget/comment.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:Anifrag/widget/text_percent.dart';
import 'package:Anifrag/widget/text_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Detail extends StatefulWidget {
  final String imagePath;

  const Detail({@required this.imagePath});

  @override
  $Detail createState() => $Detail();
}

class $Detail extends State<Detail> with TickerProviderStateMixin {
  static final double _paddingTopImage = 20;
  final double _mergeGap = 30;
  final double _heightImage = 320 + _paddingTopImage;
  static final double paddingContent = 17;
  Animation<Offset> botToTop;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    botToTop = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
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
                  SlideTransition(position: botToTop, child: _Content()),
                ],
              ),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(top: _paddingTopImage),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: HeroImage(
                          isShadow: true,
                          tag: "AtoB" + widget.imagePath,
                          path: widget.imagePath,
                          height: _heightImage,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
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
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Comment(
                        top: TextStar(
                          fontSize: 25,
                          value: 8.2,
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
              ),
              SizedBox.fromSize(
                size: Size(0, 30),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: $Detail.paddingContent),
                  child: DetailTabbar(),
                ),
              )
            ],
          ),
        ),
      );
}
