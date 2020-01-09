import 'package:flutter/widgets.dart';

import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' show radians;

class Hand extends StatelessWidget {
  final Color handColor;
  final double handWidth;
  final double handAngle;
  final double handLength;

  const Hand(
      {Key key,
      this.handColor,
      this.handWidth,
      this.handAngle,
      this.handLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HandPainter(
          handColor: handColor,
          handWidth: handWidth,
          handAngle: handAngle,
          handLength: handLength),
    );
  }
}

class HandPainter extends CustomPainter {
  final Color handColor;
  final double handWidth;
  final double handAngle;
  final double handLength;

  HandPainter(
      {@required this.handColor,
      @required this.handWidth,
      @required this.handAngle,
      @required this.handLength});

  @override
  void paint(Canvas canvas, Size size) {
    _drawHand(canvas, size, handAngle);
  }

  void _drawHand(Canvas canvas, Size size, double handAngle) {
    Offset center = (Offset.zero & size).center;

    Paint teethPaint = Paint()
      ..color = handColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = handWidth
      ..strokeCap = StrokeCap.round;

    final angle = handAngle - math.pi / 2.0;

    Offset p1 = Offset(math.cos(angle), math.sin(angle)) * handLength;
    canvas.drawLine(center, p1, teethPaint);
  }

  @override
  bool shouldRepaint(HandPainter oldDelegate) {
    return oldDelegate.handColor != handColor ||
        oldDelegate.handWidth != handWidth ||
        oldDelegate.handAngle != handAngle ||
        oldDelegate.handLength != handLength;
  }
}
