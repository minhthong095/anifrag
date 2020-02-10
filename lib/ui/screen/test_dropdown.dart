import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        showSeason,
        style: TextStyle(fontSize: 30, backgroundColor: Colors.red),
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
    final b =
        (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    final c = 0;
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
        child: _item(widget.width, widget.height, _showSeason.toString()));
  }
}

class RouteVirgilAaronDropDown extends PopupRoute {
  final Rect coordinateRect;
  final int seasonCout;
  final bool isBottomNotch;
  final bool isTopNotch;

  RouteVirgilAaronDropDown(
      {@required this.coordinateRect,
      this.seasonCout,
      this.isBottomNotch = false,
      this.isTopNotch = false});

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  Iterable<Widget> _generateItem(
      int seasonCout, double width, double height) sync* {
    for (int c = 0; c < seasonCout; c++) yield _item(width, height, "1");
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final c = '';
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
                child: SingleChildScrollView(
                  physics: _DroPDownPhysics(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.yellow.withOpacity(0.5),
                        constraints: BoxConstraints.expand(
                            height: (coordinateRect.top - coordinateRect.height)
                                    .abs() +
                                (isTopNotch
                                    ? 0
                                    : MediaQuery.of(context).viewPadding.top)),
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
                      // Container(
                      //   color: Colors.yellow.withOpacity(0.5),
                      //   constraints: BoxConstraints.expand(
                      //       height: MediaQuery.of(context).size.height -
                      //           coordinateRect.top),
                      // )
                    ],
                  ),
                ))),
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 600);
}

class _DroPDownPhysics extends ScrollPhysics {
  const _DroPDownPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  _DroPDownPhysics applyTo(ScrollPhysics ancestor) {
    return _DroPDownPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // print("applyBoundaryConditions $value");
    // if (value < position.pixels &&
    //     position.pixels <= position.minScrollExtent) // underscroll
    //   return value - position.pixels;
    // if (position.maxScrollExtent <= position.pixels &&
    //     position.pixels < value) // overscroll
    //   return value - position.pixels;
    // if (value < position.minScrollExtent &&
    //     position.minScrollExtent < position.pixels) // hit top edge
    //   return value - position.minScrollExtent;
    // if (position.pixels < position.maxScrollExtent &&
    //     position.maxScrollExtent < value) // hit bottom edge
    //   return value - position.maxScrollExtent;
    // return 0.0;
    // print("");
    // print(
    //     'applyBoundaryConditions \npixels ${position.pixels} \nminScrollExtend ${position.minScrollExtent} \nmaxScrollExtend ${position.maxScrollExtent} \nvieweportDimension ${position.viewportDimension} \nextendBefore ${position.extentBefore} \nextendsAfter ${position.extentAfter} \nextendsInside ${position.extentInside} \noutOfRange ${position.outOfRange}');
    // print("");
    final a = FixedScrollMetrics(
        maxScrollExtent: position.maxScrollExtent,
        viewportDimension: 10000,
        pixels: position.pixels,
        minScrollExtent: -1000,
        axisDirection: position.axisDirection);
    return super.applyBoundaryConditions(position, value);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // print('applyPhysicsToUserOffset $offset');
    // print("");
    // print(
    //     'applyBoundaryConditions \npixels ${position.pixels} \nminScrollExtend ${position.minScrollExtent} \nmaxScrollExtend ${position.maxScrollExtent} \nvieweportDimension ${position.viewportDimension} \nextendBefore ${position.extentBefore} \nextendsAfter ${position.extentAfter} \nextendsInside ${position.extentInside} \noutOfRange ${position.outOfRange}');
    // print("");
    final a = FixedScrollMetrics(
        maxScrollExtent: position.maxScrollExtent,
        viewportDimension: 10000,
        pixels: position.pixels,
        minScrollExtent: position.minScrollExtent,
        axisDirection: position.axisDirection);
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    print('BALLISTICS');
    return super.createBallisticSimulation(position, velocity);
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => true;
}
