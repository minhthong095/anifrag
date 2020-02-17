import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/ui/widget/custom_shadow_wrap.dart';
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
  final double offset;

  VirgilAaronDropDown(
      {this.seasonCount = 1,
      this.width = 130,
      this.height = 50,
      this.offset = 19, // adjust up and down little bit
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
        color: Color(0xff51515e).withOpacity(0.2),
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
    _initShowSeason();
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
                    offset: widget.offset,
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
  final double offset;
  final double width;
  final double height;
  final int defaultSeason;
  final bool isTopNotch;
  final FixedExtentScrollController _scrollController;
  BuildContext _context;

  RouteVirgilAaronDropDown(
      {@required this.coordinateRect,
      this.seasonCout,
      this.width,
      this.height,
      this.offset,
      this.isBottomNotch = false,
      this.defaultSeason,
      this.isTopNotch = false})
      : _scrollController =
            FixedExtentScrollController(initialItem: defaultSeason - 1);

  @override
  Color get barrierColor => Colors.white.withOpacity(0.5);

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
        child: _item(width, height, "1", onTap: () {
          _onItemTap(1);
        }));

    if (seasonCout - 2 > 0)
      for (int c = 1; c < seasonCout - 1; c++) {
        yield _item(width, height, (c + 1).toString(), onTap: () {
          _onItemTap(c + 1);
        });
      }

    if (seasonCout > 1)
      yield ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius)),
        child: _item(width, height, seasonCout.toString(), onTap: () {
          _onItemTap(seasonCout);
        }),
      );
  }

  void _onItemTap(int selectSeason) {
    Navigator.of(_context).pop(selectSeason);
  }

  double _calHeightScroll(
      BuildContext context, bool isTopNotch, bool isBottomNotch) {
    return MediaQuery.of(context).size.height * 2 -
        (isTopNotch ? MediaQuery.of(context).viewPadding.top : 0) -
        (isBottomNotch ? MediaQuery.of(context).viewPadding.bottom : 0);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    _context = context;
    final heightScroll = _calHeightScroll(context, isTopNotch, isBottomNotch);
    final offsetTop = ((heightScroll / 2 - coordinateRect.top) + offset);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(defaultSeason);
      },
      child: SafeArea(
        bottom: isBottomNotch,
        top: isTopNotch,
        child: Scaffold(
            // backgroundColor: Color.fromARGB(255, 37, 38, 54),
            backgroundColor: Colors.red.withOpacity(0.5),
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: -offsetTop,
                  left: coordinateRect.left,
                  child: SizedBox(
                    width: coordinateRect.width,
                    height: heightScroll,
                    child: Container(
                      color: Colors.green.withOpacity(0.5),
                      child: ListWheelScrollView(
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
                )
              ],
            )),
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 1);
}
