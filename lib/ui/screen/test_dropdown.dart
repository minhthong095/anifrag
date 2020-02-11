import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class TestDropDown extends StatelessWidget {
  final data = <int>[
    1,
    2,
    3,
    4,
    5,
    6,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: AppColor.backgroundColor,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Navigator.pushAndRemoveUntil(context,
            //     MaterialPageRoute(builder: (_) => MyApp2()), (route) => false);
          },
          child: ListView.separated(
            separatorBuilder: (context, position) {
              return SizedBox(
                height: 100,
                width: double.infinity,
              );
            },
            itemBuilder: (context, position) {
              return Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  child: VirgilAaronDropDown(
                    isBottomNotch: true,
                    isTopNotch: true,
                    seasonCount: 8,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              );
            },
            itemCount: data.length,
          ),
        ),
      )),
    );
  }
}

class VirgilAaronDropDown extends StatefulWidget {
  final int seasonCount;
  final int defaultSeason;
  final double width;
  final double height;
  final bool isTopNotch;
  final bool isBottomNotch;

  VirgilAaronDropDown(
      {this.seasonCount = 1,
      this.width = 120,
      this.height = 45,
      this.isBottomNotch = false,
      this.isTopNotch = false,
      this.defaultSeason = 1});
  @override
  _VirgilAaronDropDownState createState() => _VirgilAaronDropDownState();
}

Widget _item(double width, double height, String showSeason) => Container(
      width: width,
      height: height,
      color: Color.fromARGB(255, 37, 38, 54),
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            showSeason,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );

class _VirgilAaronDropDownState extends State<VirgilAaronDropDown> {
  int _showSeason;

  @override
  void initState() {
    _showSeason = widget.defaultSeason;
    super.initState();
  }

  Rect get _findRenderBox {
    (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    return (context.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero) &
        Size(widget.width, widget.height);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              RouteVirgilAaronDropDown(
                  isBottomNotch: widget.isBottomNotch,
                  isTopNotch: widget.isTopNotch,
                  coordinateRect: _findRenderBox,
                  seasonCout: widget.seasonCount));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: _item(widget.width, widget.height, _showSeason.toString()),
        ));
  }
}

class RouteVirgilAaronDropDown extends PopupRoute {
  final Rect coordinateRect;
  final int seasonCout;
  final bool isBottomNotch;
  final bool isTopNotch;
  final ScrollController _scrollController = ScrollController();
  bool _isCompleteAutoFix = true;

  RouteVirgilAaronDropDown(
      {@required this.coordinateRect,
      this.seasonCout,
      this.isBottomNotch = false,
      this.isTopNotch = false});

  @override
  Color get barrierColor => AppColor.backgroundColor.withOpacity(0.9);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  Iterable<Widget> _generateItem(
      int seasonCout, double width, double height) sync* {
    for (int c = 0; c < seasonCout; c++) yield _item(width, height, "1");
  }

  double _goTo(double pixels, double baseHeight) {
    final result = ((((pixels + 1) / baseHeight).round()) * baseHeight) - 1;
    return result < 0 ? 0 : result;
  }

  bool _scrollNotification(UserScrollNotification notification) {
    final position = _scrollController.position;

    if (notification.direction == ScrollDirection.idle &&
        _isCompleteAutoFix &&
        position.pixels > 0 &&
        position.pixels <= position.maxScrollExtent) {
      final goTo = _goTo(position.pixels, coordinateRect.height);
      _isCompleteAutoFix = false;
      _scrollController
          .animateTo(goTo,
              duration: Duration(milliseconds: 100), curve: Curves.decelerate)
          .whenComplete(() {
        _isCompleteAutoFix = true;
      });
    }

    return false;
  }

  @override
  bool didPop(result) {
    _scrollController.dispose();
    return super.didPop(result);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: SafeArea(
        bottom: isBottomNotch,
        top: isTopNotch,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
                width: coordinateRect.width,
                height: double.infinity,
                color: Colors.green.withOpacity(0.5),
                margin: EdgeInsets.only(left: coordinateRect.left),
                child: NotificationListener<UserScrollNotification>(
                  onNotification: _scrollNotification,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.yellow.withOpacity(0.5),
                          constraints: BoxConstraints.expand(
                              height:
                                  (coordinateRect.top - coordinateRect.height)
                                          .abs() +
                                      (isTopNotch
                                          ? 0
                                          : MediaQuery.of(context)
                                              .viewPadding
                                              .top)),
                        ),
                        ..._generateItem(seasonCout, coordinateRect.width,
                            coordinateRect.height),
                        Container(
                          color: Colors.yellow.withOpacity(0.5),
                          constraints: BoxConstraints.expand(
                              height: MediaQuery.of(context).size.height -
                                  (coordinateRect.top +
                                          coordinateRect.height +
                                          (isBottomNotch
                                              ? MediaQuery.of(context)
                                                  .viewPadding
                                                  .bottom
                                              : 0))
                                      .abs()),
                        )
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 600);
}
