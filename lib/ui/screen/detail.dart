import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/ui/widget/button_circle.dart';
import 'package:Anifrag/ui/widget/detail_tabbar.dart';

import 'package:Anifrag/ui/widget/comment.dart';
import 'package:Anifrag/ui/widget/hero_image.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:Anifrag/ui/widget/text_percent.dart';
import 'package:Anifrag/ui/widget/text_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Detail extends StatefulWidget {
  static const String nameRoute = '/detail';

  final DetailArguments arguments;

  const Detail({this.arguments});

  @override
  _Detail createState() => _Detail();
}

class _Detail extends State<Detail> with SingleTickerProviderStateMixin {
  static final double _paddingTopImage = 20;
  final double _mergeGap = 30;
  final double _heightImage = 320 + _paddingTopImage;
  double _defaultDiameterCircle = 0;
  static final double paddingContent = 17;
  Animation<Offset> _animationBotToTop;
  Animation<double> _animationCircle;
  Animation<double> _animationPaddingCircle;
  Animation<double> _animationOpacityCircle;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationBotToTop = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_controller);
    _animationCircle = Tween<double>(begin: 0, end: 2.5).animate(_controller);
    _animationPaddingCircle =
        Tween<double>(begin: 0, end: 15).animate(_controller);
    _animationOpacityCircle = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInQuint))
        .animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getSizeOfCircle();
    super.didChangeDependencies();
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
                          child: Container(
                            constraints: BoxConstraints.tightFor(
                                height: _defaultDiameterCircle),
                            decoration: BoxDecoration(
                                color: AppColor.yellow, shape: BoxShape.circle),
                          ),
                        );
                      },
                    ),
                  ),
                  SlideTransition(
                      position: _animationBotToTop, child: _Content()),
                ],
              ),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(top: _paddingTopImage),
                  child: Container(
                    constraints: BoxConstraints.expand(height: _heightImage),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: AnimatedBuilder(
                              animation: _controller,
                              child: ButtonCircle(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                iconPath: PathIcon.back,
                              ),
                              builder: (BuildContext context, Widget child) =>
                                  Padding(
                                padding: EdgeInsets.only(
                                    left: _animationPaddingCircle.value,
                                    top: 20),
                                child: Opacity(
                                  opacity: _controller.value, // 0 to 1
                                  child: child,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context)
                                .pushNamed(LoadingRoute.nameRoute);
                            await new Future.delayed(
                                const Duration(seconds: 3));
                            Navigator.of(context).popUntil(
                                ModalRoute.withName(Detail.nameRoute));
                          },
                          // child: HeroImage(
                          //   isShadow: true,
                          //   tag: widget.arguments.tagPrefix +
                          //       widget.arguments.imagePath,
                          //   path: widget.arguments.imagePath,
                          //   height: _heightImage,
                          //   fit: BoxFit.fill,
                          // ),
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(blurRadius: 30, color: Colors.grey[600])
                            ]),
                            child: HeroImage(
                              tag: widget.arguments.tagPrefix +
                                  widget.arguments.imagePath,
                              path: widget.arguments.imagePath,
                              height: _heightImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: AnimatedBuilder(
                              animation: _controller,
                              child: ButtonCircle(
                                onTap: () {},
                                padding: 11,
                                iconPath: PathIcon.share,
                              ),
                              builder: (BuildContext context, Widget child) =>
                                  Padding(
                                padding: EdgeInsets.only(
                                    right: _animationPaddingCircle.value,
                                    top: 20),
                                child: Opacity(
                                  opacity:
                                      _animationOpacityCircle.value, // 0 to 1
                                  child: child,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: AppColor.backgroundColor,
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
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
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
                      EdgeInsets.symmetric(horizontal: _Detail.paddingContent),
                  child: DetailTabbar(),
                ),
              )
            ],
          ),
        ),
      );
}

class DetailArguments {
  final String imagePath;
  final String tagPrefix;

  const DetailArguments({@required this.imagePath, @required this.tagPrefix});
}
