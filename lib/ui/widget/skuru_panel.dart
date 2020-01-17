import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class SkuruPanel extends StatelessWidget {
  final _paddingRightTitle = 13.0;
  final double height;

  SkuruPanel({double height})
      : this.height = height == null || height < 100 ? 100 : height;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: height),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(right: _paddingRightTitle),
              constraints: BoxConstraints.expand(),
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text('ABCDEFGHABCDEFGHABCDEFGHADF'),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30))),
            ),
          ),
          Expanded(
            flex: 3,
            child: _SkyCustomPaint(),
          )
        ],
      ),
    );
  }
}

class _SkyCustomPaint extends StatefulWidget {
  @override
  __SkyCustomPaintState createState() => __SkyCustomPaintState();
}

class __SkyCustomPaintState extends State<_SkyCustomPaint>
    with SingleTickerProviderStateMixin {
  final _paddingRightTitle = 13.0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: pi),
          curve: Curves.easeInOutQuart,
          duration: Duration(seconds: 2),
          builder: (_, value, widget) {
            return CustomPaint(
              size: constraint.biggest,
              painter: _Sky(
                  offsetXCircle: _paddingRightTitle, radiusAnimation: value),
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
  final double radiusAnimation;
  final double startPoint;
  final int value = 0;

  _Sky(
      {double offsetXCircle,
      Color colorLine,
      Color colorLineBase,
      double startPoint,
      @required this.radiusAnimation})
      : this.offsetXCircle = offsetXCircle ?? 0,
        this.startPoint = startPoint ?? -pi / 2,
        this.colorLineBase = colorLineBase ?? Colors.grey,
        this.colorLine = colorLine ?? Colors.yellow;

  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()..color = Colors.white;
    final ratioPadding = 0.45; // relative to radius // ##
    final radius = .42 * size.width; // ##
    final yCircle = -ratioPadding * radius + radius;
    final _offsetCircle = Offset(radius - offsetXCircle, yCircle);

    canvas.drawCircle(_offsetCircle, radius, circlePaint);
    final paintLine = Paint()
      ..color = Colors.white
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
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: paragraphSize,
              ))
              ..addText('  92'))
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
