import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Rotor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RotorPainter(),
    );
  }
}

class RotorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint topRotorPaint = Paint()
    ..color = Colors.black;
    Offset center = (Offset.zero & size).center;
    Rect rect = Rect.fromCenter(center: center, width: 12, height: 12);
    Rect rect2 = Rect.fromLTRB(12, 0, 34, 35);
    Image image;

    canvas.drawRect(rect2, topRotorPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }


}