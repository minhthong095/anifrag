import 'dart:math';
import 'dart:ui' as ui;

import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SkuruPanel extends StatelessWidget {
  /// Hard code, this is a bug. Temporary have not solution yet.
  static const double _yUnitHideGap = -25;

  final _paddingRightTitle = 13.0;
  final double height;
  final Color backgroundColor;
  final Color titleColor;
  final String title;
  final double paddingLeftTitle;
  final double percentPoint;

  SkuruPanel(
      {@required this.height,
      this.backgroundColor = Colors.white,
      this.titleColor,
      this.title,
      double percentPoint,
      this.paddingLeftTitle})
      : this.percentPoint = percentPoint ?? 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.backgroundColor,
      constraints: BoxConstraints.expand(height: height),
      child: Transform.translate(
        offset: Offset(0, _yUnitHideGap),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(right: _paddingRightTitle),
                constraints: BoxConstraints.expand(),
                child: Padding(
                  padding: EdgeInsets.only(top: 18, left: paddingLeftTitle),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: this.titleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Crime, Thriller',
                          style:
                              TextStyle(color: this.titleColor, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30))),
              ),
            ),
            Expanded(
              flex: 3,
              child: _SkyCustomPaint(
                percentPoint: percentPoint,
                backgroundColor: backgroundColor,
                colorValue: titleColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SkyCustomPaint extends StatefulWidget {
  final Color backgroundColor;
  final Color colorValue;
  final double percentPoint;

  _SkyCustomPaint({this.backgroundColor, this.colorValue, this.percentPoint});

  @override
  __SkyCustomPaintState createState() => __SkyCustomPaintState();
}

class __SkyCustomPaintState extends State<_SkyCustomPaint>
    with SingleTickerProviderStateMixin {
  final _paddingRightTitle = 13.0;
  int count = 0;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.forward();
    _animation = Tween<double>(begin: 0, end: (widget.percentPoint * pi) / 5)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(_SkyCustomPaint oldWidget) {
    _animationController.reset();
    _animationController.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, child) {
            return CustomPaint(
              size: constraint.biggest,
              painter: _Sky(
                  colorValue: widget.colorValue,
                  percentPoint: widget.percentPoint,
                  backgroundColor: widget.backgroundColor,
                  offsetXCircle: _paddingRightTitle,
                  radiusAnimation: _animation.value),
            );
          },
        );
      },
    );
  }
}

class _Sky extends CustomPainter {
  final double offsetXCircle;
  final Color colorLine;
  final Color colorLineBase;
  final Color colorValue;
  final double radiusAnimation;
  final double percentPoint;
  final double startPoint;
  final int value = 0;
  final Color backgroundColor;

  _Sky(
      {double offsetXCircle,
      Color colorLine,
      Color colorLineBase,
      this.colorValue,
      double startPoint,
      this.percentPoint,
      this.backgroundColor,
      @required this.radiusAnimation})
      : this.offsetXCircle = offsetXCircle ?? 0,
        this.startPoint = startPoint ?? -pi / 2,
        this.colorLineBase = colorLineBase ?? Colors.grey,
        this.colorLine = colorLine ?? AppColor.yellow;
  final ratioPadding = 0.45; // relative to radius // ##

  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()..color = backgroundColor;
    final radius = .42 * size.width; // ##
    final yCircle = -ratioPadding * radius + radius;
    final _offsetCircle = Offset(radius - offsetXCircle, yCircle);

    canvas.drawCircle(_offsetCircle, radius, circlePaint);
    final paintLine = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final xA = radius * 2 - offsetXCircle;
    final yA = yCircle;

    final xB = size.width;
    final yB = (yCircle - radius) - 5;

    final xI = (xA + xB) / 2;
    final yI = (yA + yB) / 2;

    final midperpendiculars = 11;
    final xBezierCtlPoint = xI + midperpendiculars;
    final yBezierCtlPoint = yI + midperpendiculars;

    final xC = size.width;
    final yC = size.height;

    final xD = 0.0;
    final yD = size.height;

    final xE = 0.0;
    final yE = radius - offsetXCircle;

    canvas.drawPath(
        Path()
          ..moveTo(xA, yA)
          ..quadraticBezierTo(
              xBezierCtlPoint, yBezierCtlPoint, xB, yB - 10) // bezier
          ..lineTo(xC, yC)
          ..lineTo(xD - 1, yD) // remove gap on the left container
          ..lineTo(xE - 1, yE),
        paintLine);

    final stokeCircleWidth = 7.5;
    final radiusBaseCircle = 0.75 * radius;

    final circleBaseLinePaint = Paint()
      ..color = colorLineBase
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeCircleWidth;
    canvas.drawCircle(_offsetCircle, radiusBaseCircle, circleBaseLinePaint);

    final paragraphLength = radiusBaseCircle * 2;
    final paragraphSize = radiusBaseCircle - stokeCircleWidth;
    canvas.drawParagraph(
        (ui.ParagraphBuilder(ui.ParagraphStyle(maxLines: 1))
              ..pushStyle(ui.TextStyle(
                height: 1,
                color: colorValue,
                fontWeight: FontWeight.bold,
                fontSize: paragraphSize,
              ))
              ..addText(' ${percentPoint.toString()}'))
            .build()
              ..layout(ui.ParagraphConstraints(width: paragraphLength)),
        Offset(_offsetCircle.dx - paragraphLength / 2 + stokeCircleWidth,
            paragraphSize / 2));

    final _radiusBaseCircle = 0.75 * radius;

    final _circleMainLinePaint = Paint()
      ..color = colorLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeCircleWidth;
    canvas.drawCircle(_offsetCircle, radiusBaseCircle, circleBaseLinePaint);

    canvas.drawArc(
        Rect.fromCircle(center: _offsetCircle, radius: _radiusBaseCircle),
        startPoint, // start point
        radiusAnimation,
        false,
        _circleMainLinePaint);
  }

  @override
  bool shouldRepaint(_Sky oldDelegate) => true;
}
