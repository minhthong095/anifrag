import 'package:flutter/material.dart';

class TestCustomShadowWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaskWithHole(
          width: double.infinity,
          height: double.infinity,
          coordinateRect: Rect.fromLTWH(200, 200, 100, 100),
        ),
      ),
    );
  }
}

class MaskWithHole extends StatelessWidget {
  final double height;
  final double width;
  final Rect coordinateRect; // Inside big Rect with height, width above
  final BorderRadius borderRadius;
  final Color color;

  MaskWithHole(
      {@required this.width,
      @required this.height,
      @required this.coordinateRect,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.color = Colors.green});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(width, height),
        painter: _Painter(rectChild: coordinateRect, color: color));
  }
}

class _Painter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color color;
  final Rect rectChild;

  _Painter({this.borderRadius, this.color, @required this.rectChild});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = color;
    canvas.drawPath(
        Path()
          ..fillType = PathFillType.evenOdd
          ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
          ..addRRect(RRect.fromRectAndRadius(rectChild, Radius.circular(10))),
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
