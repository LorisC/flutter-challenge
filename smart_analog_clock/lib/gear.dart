import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' show radians;

class Gear extends StatelessWidget {
  final int teethNumber;

  final double toothSize;
  final double teethWidth;
  final Color teethColor;

  final double gearRadius;
  final double gearWidth;
  final Color gearColor;

  const Gear(
      {Key key,
      @required this.teethNumber,
      @required this.toothSize,
      @required this.gearRadius,
      @required this.teethWidth,
      @required this.teethColor,
      @required this.gearWidth,
      @required this.gearColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GearPainter(
        gearColor: gearColor,
        gearRadius: gearRadius,
        gearWidth: gearWidth,
        teethColor: teethColor,
        teethLength: toothSize,
        teethWidth: teethWidth,
        teethNumber: teethNumber
      ),
    );
  }
}

/// [CustomPainter] that draws a gear.
class _GearPainter extends CustomPainter {

  final double gearRadius;
  final double gearWidth;
  final Color gearColor;

  final int teethNumber;
  final double teethWidth;
  final double teethLength;
  final Color teethColor;

  _GearPainter(
      {@required this.gearRadius,
      @required this.gearWidth,
      @required this.gearColor,
      @required this.teethColor,
      @required this.teethWidth,
      @required this.teethLength,
      @required this.teethNumber})
      : assert(gearRadius != null),
        assert(teethWidth != null),
        assert(gearColor != null),
        assert(gearRadius >= 0.0),
        assert(teethLength >= 0.0);



  @override
  void paint(Canvas canvas, Size size) {
    _drawGearCircle(canvas, size);
    _drawGearTooth(canvas, size);
  }

  void _drawGearCircle(Canvas canvas, Size size) {
    final Offset center = (Offset.zero & size).center;

    final Paint gearPaint = Paint()
      ..color = gearColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = gearWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, gearRadius, gearPaint);
  }

  void _drawGearTooth(Canvas canvas, Size size){
    double angleIncrease = 360 / teethNumber;
    for (int i = 0; i < teethNumber; i++) {
      _drawGearTeeth(canvas, size, 90.0 + angleIncrease * i);
    }
  }

  void _drawGearTeeth(Canvas canvas, Size size, double teethAngle) {

    Offset center = (Offset.zero & size).center;

    Paint teethPaint = Paint()
      ..color = teethColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = teethWidth
      ..strokeCap = StrokeCap.round;
    double angle = radians(teethAngle) - math.pi / 2.0;

    Offset p1 = Offset(math.cos(angle), math.sin(angle)) * teethLength;
    canvas.drawLine(center, p1, teethPaint);
  }

  @override
  bool shouldRepaint(_GearPainter oldDelegate) {
    return false;
  }
}
