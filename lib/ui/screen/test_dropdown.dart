import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/ui/widget/custom_shadow_wrap.dart';
import 'package:Anifrag/ui/widget/small_arrow_dropdown.dart';
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
              final min = 1;
              final seasonCount = min + math.Random().nextInt(20 - min);
              final defaultSeason = min +
                  math.Random().nextInt(
                      seasonCount - min > min ? seasonCount - min : min);
              return Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  child: VirgilAaronDropDown(
                    isBottomNotch: true,
                    isTopNotch: true,
                    defaultSeason: defaultSeason,
                    seasonCount: seasonCount,
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
      this.width = 130,
      this.height = 50,
      this.isBottomNotch = false,
      this.isTopNotch = false,
      this.defaultSeason = 1});
  @override
  _VirgilAaronDropDownState createState() => _VirgilAaronDropDownState();
}

Widget _item(double width, double height, String showSeason,
    {void Function() onTap}) {
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: onTap,
      onTap: () {
        print("haha");
        if (onTap != null) onTap();
      },
      child: Container(
        width: width,
        height: height,
        // color: Color.fromARGB(255, 37, 38, 54),
        color: Color(0xff51515e),
        // decoration:
        //     BoxDecoration(border: Border.all(color: Colors.red, width: 2)),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Season ' + showSeason,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ));
}

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
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child:
          _item(widget.width, widget.height, _showSeason.toString(), onTap: () {
        Navigator.push(
                context,
                RouteVirgilAaronDropDown(
                    isBottomNotch: widget.isBottomNotch,
                    isTopNotch: widget.isTopNotch,
                    defaultSeason: _showSeason,
                    width: widget.width,
                    height: widget.height,
                    coordinateRect: _findRenderBox,
                    seasonCout: widget.seasonCount))
            .then<int>((onValue) {
          if (onValue != null) {
            setState(() {
              _showSeason = onValue;
            });
          }
          return onValue;
        });
      }),
    );
  }
}

class RouteVirgilAaronDropDown extends PopupRoute {
  final Rect coordinateRect;
  final int seasonCout;
  final bool isBottomNotch;
  final double width;
  final double height;
  final int defaultSeason;
  final bool isTopNotch;

  RouteVirgilAaronDropDown(
      {@required this.coordinateRect,
      this.seasonCout,
      this.width,
      this.height,
      this.isBottomNotch = false,
      this.defaultSeason,
      this.isTopNotch = false});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _DropWrapStateful(
        isBottomNotch: isBottomNotch,
        isTopNotch: isTopNotch,
        defaultSeason: defaultSeason,
        width: width,
        height: height,
        coordinateRect: coordinateRect,
        seasonCout: seasonCout);
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 600);
}

class _DropWrapStateful extends StatefulWidget {
  final Rect coordinateRect;
  final int seasonCout;
  final bool isBottomNotch;
  final double width;
  final double height;
  final int defaultSeason;
  final bool isTopNotch;
  final ScrollController _scrollController;

  _DropWrapStateful(
      {@required this.coordinateRect,
      this.seasonCout,
      this.width,
      this.height,
      this.isBottomNotch = false,
      this.defaultSeason,
      this.isTopNotch = false})
      : _scrollController = ScrollController(
            initialScrollOffset: _goToDefault(defaultSeason, height));

  static double _goToDefault(int defaultSeason, double height) {
    final result = ((defaultSeason - 1) * height) - 1;
    return result < 0 ? 0 : result;
  }

  @override
  _DropWrapStatefulState createState() => _DropWrapStatefulState();
}

class _DropWrapStatefulState extends State<_DropWrapStateful> {
  Iterable<Widget> _generateItem(
      int seasonCout, double width, double height, BuildContext context) sync* {
    final borderRadius = 10.0;
    yield ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius)),
        child: _item(width, height, "1", onTap: () {
          _onItemTap(1);
        }));

    for (int c = 1; c < seasonCout - 1; c++) {
      yield _item(width, height, (c + 1).toString(), onTap: () {
        _onItemTap(c + 1);
      });
    }

    if (seasonCout != widget.defaultSeason)
      yield ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius)),
        child: _item(width, height, seasonCout.toString(), onTap: () {
          _onItemTap(seasonCout);
        }),
      );
  }

  double _goTo(double pixels, double baseHeight) {
    final result = ((((pixels + 1) / baseHeight).round()) * baseHeight) - 1;
    return result < 0 ? 0 : result;
  }

  bool _isIdle = true;

  bool _scrollNotification(UserScrollNotification notification) {
    final position = widget._scrollController.position;
    print(notification.direction);
    if (notification.direction == ScrollDirection.idle &&
        position.pixels > 0 &&
        _isIdle &&
        position.pixels <= position.maxScrollExtent) {
      // Temporary hard code when user drag so dam hard
      setState(() {
        _isIdle = false;
      });
      final goTo = _goTo(position.pixels, widget.coordinateRect.height);
      widget._scrollController
          .animateTo(goTo,
              duration: Duration(milliseconds: 100), curve: Curves.decelerate)
          .then((o) {
        // Temporary hard code when user drag so dam hard
        setState(() {
          _isIdle = true;
        });
      });
    }

    return false;
  }

  void _onItemTap(int selectSeason) {
    Navigator.of(context).pop(selectSeason);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(widget.defaultSeason);
      },
      child: SafeArea(
        bottom: widget.isBottomNotch,
        top: widget.isTopNotch,
        child: Stack(children: [
          Scaffold(
              backgroundColor: Color.fromARGB(255, 37, 38, 54),
              body: Container(
                  width: widget.coordinateRect.width,
                  height: double.infinity,
                  margin: EdgeInsets.only(left: widget.coordinateRect.left),
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: _scrollNotification,
                    child: SingleChildScrollView(
                      physics: _isIdle
                          ? ClampingScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      controller: widget._scrollController,
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            constraints: BoxConstraints.expand(
                                height: (widget.coordinateRect.top -
                                            widget.coordinateRect.height)
                                        .abs() +
                                    (widget.isTopNotch
                                        ? 0
                                        : MediaQuery.of(context)
                                            .viewPadding
                                            .top)),
                          ),
                          ..._generateItem(
                              widget.seasonCout,
                              widget.coordinateRect.width,
                              widget.coordinateRect.height,
                              context),
                          Container(
                            constraints: BoxConstraints.expand(
                                height: MediaQuery.of(context).size.height -
                                    (widget.coordinateRect.top +
                                            widget.coordinateRect.height +
                                            (widget.isBottomNotch
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
          Positioned.fill(
              child: IgnorePointer(
            child: MaskWithHole(
              color: Colors.black.withOpacity(0.5),
              height: double.infinity,
              width: double.infinity,
              coordinateRect: Rect.fromLTWH(
                  widget.coordinateRect.left,
                  widget.coordinateRect.top - widget.coordinateRect.height,
                  widget.coordinateRect.width,
                  widget.coordinateRect.height),
            ),
          ))
        ]),
      ),
    );
  }
}
