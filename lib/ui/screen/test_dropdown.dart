import 'dart:async';

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
              final minSeason = 1;
              final maxSeason = 20;
              final seasonCount =
                  minSeason + math.Random().nextInt(maxSeason - minSeason);
              final maxDefaultSeason = seasonCount;
              final defaultSeason = seasonCount == 1
                  ? 1
                  : minSeason +
                      math.Random().nextInt(maxDefaultSeason - minSeason);

              print("defaultSeason: $defaultSeason");
              print("seasonCount: $seasonCount");

              return Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  child: VirgilAaronDropDown(
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

  VirgilAaronDropDown(
      {this.seasonCount = 1,
      this.width = 140,
      this.height = 50,
      this.defaultSeason = 1});
  @override
  _VirgilAaronDropDownState createState() => _VirgilAaronDropDownState();
}

Widget _item(double width, double height, String showSeason) {
  return Container(
    width: width,
    height: height,
    color: Color(0xff51515e),
    // decoration: BoxDecoration( // test
    //     border: Border.all(color: Colors.red.withOpacity(0.5), width: 2)),
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
  );
}

class _VirgilAaronDropDownState extends State<VirgilAaronDropDown>
    with SingleTickerProviderStateMixin {
  int _showSeason;
  AnimationController _animationController;
  Animation<double> _animation;
  static const start = 1.0;
  static const end = 0.92;

  @override
  void initState() {
    _initShowSeason();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = TweenSequence<double>([
      TweenSequenceItem(
          weight: 50, tween: Tween<double>(begin: start, end: end)),
      TweenSequenceItem(
          weight: 50, tween: Tween<double>(begin: end, end: start))
    ]).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(VirgilAaronDropDown oldWidget) {
    _initShowSeason();
    super.didUpdateWidget(oldWidget);
  }

  void _initShowSeason() {
    _showSeason = widget.defaultSeason;
  }

  Rect get _findRenderBox {
    (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    return (context.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero) &
        Size(widget.width, widget.height);
  }

  void _onClick() {
    _animationController.reset();
    _animationController.forward().then((f) {
      Navigator.push(
              context,
              RouteVirgilAaronDropDown(
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // return ClipRRect(
    //   borderRadius: BorderRadius.all(Radius.circular(10)),
    //   child: _item(widget.width, widget.height, _showSeason.toString(),
    //       onTap: _onClick),
    // );
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, widget) {
        return Transform.scale(
          scale: _animation.value,
          child: widget,
        );
      },
      child: GestureDetector(
        onTap: _onClick,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: _item(widget.width, widget.height, _showSeason.toString())),
      ),
    );
  }
}

class RouteVirgilAaronDropDown extends PopupRoute {
  final Rect coordinateRect;
  final int seasonCout;
  final double width;
  final double height;
  final int defaultSeason;
  final FixedExtentScrollController _scrollController;
  BuildContext _context;
  StreamController<ScrollDirection> _streamScrollNotification =
      StreamController();

  RouteVirgilAaronDropDown({
    @required this.coordinateRect,
    this.seasonCout,
    this.width,
    this.height,
    this.defaultSeason,
  }) : _scrollController =
            FixedExtentScrollController(initialItem: defaultSeason - 1);

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  Iterable<Widget> _generateItem(
      int seasonCout, double width, double height, BuildContext context) sync* {
    final borderRadius = 10.0;
    yield ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius)),
        child: _item(width, height, "1"));

    if (seasonCout - 2 > 0)
      for (int c = 1; c < seasonCout - 1; c++) {
        yield _item(width, height, (c + 1).toString());
      }

    if (seasonCout > 1)
      yield ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius)),
        child: _item(width, height, seasonCout.toString()),
      );
  }

  void _onSelectItemTap() {
    Navigator.of(_context).pop(_scrollController.selectedItem + 1);
  }

  double _calHeightScroll(BuildContext context) {
    // final a = MediaQuery.of(context).viewPadding.top;
    // final b = MediaQuery.of(context).viewPadding.bottom;
    return MediaQuery.of(context).size.height * 2;
  }

  bool _scrollNotification(UserScrollNotification notification) {
    _streamScrollNotification.sink.add(notification.direction);
    return false;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    _context = context;
    final heightScroll = _calHeightScroll(context);
    final offsetTop = (heightScroll / 2) -
        coordinateRect.top +
        coordinateRect.height / 2 -
        coordinateRect.height;
    final topCoordinateRect = coordinateRect.top;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(defaultSeason);
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          // backgroundColor: Color.fromARGB(255, 37, 38, 54),
          // backgroundColor: Colors.red.withOpacity(0.5),
          body: Stack(
            children: <Widget>[
              Positioned(
                top: -offsetTop,
                left: coordinateRect.left,
                child: SizedBox(
                  width: coordinateRect.width,
                  height: heightScroll,
                  child: Container(
                    child: NotificationListener<UserScrollNotification>(
                      onNotification: _scrollNotification,
                      child: GestureDetector(
                        onTap: _onSelectItemTap,
                        child: ListWheelScrollView(
                          // onItemClick in children still has an open issue
                          diameterRatio: 99,
                          itemExtent: coordinateRect.height,
                          physics: FixedExtentScrollPhysics(),
                          controller: _scrollController,
                          children: <Widget>[
                            ..._generateItem(seasonCout, coordinateRect.width,
                                coordinateRect.height, context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                  child: IgnorePointer(
                child: MaskWithHole(
                  color: Colors.black.withOpacity(0.5),
                  height: double.infinity,
                  width: double.infinity,
                  coordinateRect: Rect.fromLTWH(
                      coordinateRect.left,
                      topCoordinateRect,
                      coordinateRect.width,
                      coordinateRect.height),
                ),
              )),
              StreamBuilder<ScrollDirection>(
                stream: _streamScrollNotification.stream.distinct(),
                initialData: ScrollDirection.idle,
                builder: (_, snapshot) {
                  return Positioned(
                    top: topCoordinateRect,
                    left: coordinateRect.left,
                    width: coordinateRect.width,
                    height: coordinateRect.height,
                    child: Container(
                      // color: Colors.orange.withOpacity(0.5),
                      constraints: BoxConstraints.expand(),
                      padding: EdgeInsets.only(right: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SmallArrowDropDown(
                            isBold: snapshot.data == ScrollDirection.forward,
                            smallArrowType: SmallArrowType.up,
                          ),
                          SizedBox.fromSize(
                            size: Size(0, 6),
                          ),
                          SmallArrowDropDown(
                            isBold: snapshot.data == ScrollDirection.reverse,
                            smallArrowType: SmallArrowType.down,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          )),
    );
  }

  @override
  bool didPop(result) {
    _streamScrollNotification.close();
    _scrollController.dispose();
    return super.didPop(result);
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 1);
}
