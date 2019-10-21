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
  final String tagPrefix;

  const Detail({@required this.imagePath, @required this.tagPrefix});

  @override
  $Detail createState() => $Detail();
}

class $Detail extends State<Detail> with SingleTickerProviderStateMixin {
  static final double _paddingTopImage = 20;
  final double _mergeGap = 30;
  final double _heightImage = 320 + _paddingTopImage;
  double _defaultDiameterCircle = 0;
  static final double paddingContent = 17;
  Animation<Offset> _botToTop;
  Animation<double> _animationCircle;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _botToTop = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_controller);
    _animationCircle = Tween<double>(begin: 0, end: 2.5).animate(_controller);

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
                    child: AnimatedBuilder(
                      animation: _animationCircle,
                      builder: (context, animation) {
                        return Transform.scale(
                          scale: _animationCircle.value,
                          child: Opacity(
                            opacity: 1,
                            child: Container(
                              constraints: BoxConstraints.tightFor(
                                  height: _defaultDiameterCircle),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SlideTransition(position: _botToTop, child: _Content()),
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
                          tag: widget.tagPrefix + widget.imagePath,
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

  void _getSizeOfCircle() {
    final widthScreen = MediaQuery.of(context).size.width;
    if (widthScreen < 300) {
      _defaultDiameterCircle = widthScreen;
    } else {
      _defaultDiameterCircle = 300;
    }

    _animationCircle = Tween<double>(begin: 0, end: 2.5).animate(_controller);
  }
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
