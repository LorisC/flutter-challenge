import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' show radians;

class Dial extends StatelessWidget {
  final double dialRadius;
  final double dialWidth;
  final Color dialColor;

  final int tickNumber;
  final Color tickColor;
  final List<int> timeIndicators;
  final double timeIndicatorsSize;
  final double tickSize;

  const Dial(
      {Key key,
      this.dialColor,
      this.dialRadius,
      this.dialWidth,
      this.tickNumber,
      this.tickColor,
      this.timeIndicators = const [], this.timeIndicatorsSize, this.tickSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DialPainter(
          dialColor: dialColor,
          dialRadius: dialRadius,
          dialWidth: dialWidth,
          tickNumber: tickNumber,
          tickColor: tickColor,
          timeIndicators: timeIndicators,
          timeIndicatorSize: timeIndicatorsSize,
        tickSize: tickSize
      ),
    );
  }
}

/// [CustomPainter] that draws a clock dial.
class _DialPainter extends CustomPainter {
  final double dialRadius;
  final double dialWidth;
  final Color dialColor;
  final int tickNumber;
  final Color tickColor;
  final List<int> timeIndicators;
  final double tickSize;
   double timeIndicatorSize;

  Paint tickPaint;
  TextPainter textPainter;
  TextStyle textStyle;

  _DialPainter( {
    @required this.timeIndicatorSize,
    @required this.dialRadius,
    @required this.dialWidth,
    @required this.dialColor,
    @required this.tickNumber,
    @required this.tickColor,
    @required this.timeIndicators,
    this.tickSize = 3,
  })  : assert(dialRadius != null),
        assert(dialColor != null),
        assert(dialRadius >= 0.0),
        assert(tickNumber >= 0.0) {
    tickPaint = Paint()
      ..color = tickColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = tickSize
      ..strokeCap = StrokeCap.round;

    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );


    textStyle =  TextStyle(
      color: Colors.red,
      fontFamily: 'Times New Roman',
      fontSize:  timeIndicatorSize,
      height: 40
    );


  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawDial(canvas, size);
    _drawTicks(canvas, size);
    if (timeIndicators.length > 0) _drawTimes(canvas, size);
  }

  void _drawDial(Canvas canvas, Size size) {
    final Offset center = (Offset.zero & size).center;

    final Paint gearPaint = Paint()
      ..color = dialColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = dialWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, dialRadius, gearPaint);
  }

  void _drawTick(Canvas canvas, Size size, double tickAngle, bool isDifferentSize) {
    double angle = radians(tickAngle) - math.pi / 2.0;

    Offset p1 = Offset(math.cos(angle), math.sin(angle)) *
        (dialRadius + (isDifferentSize ? 10 : 0));
    Offset p2 = Offset(math.cos(angle), math.sin(angle)) * (dialRadius + 10 + tickSize);

    canvas.drawLine(p2, p1, tickPaint);
  }

  void _drawTicks(Canvas canvas, Size size) {
    double angleIncrease = 360 / tickNumber;
    for (int i = 0; i < tickNumber; i++) {
      _drawTick(canvas, size, 90.0 + angleIncrease * i,
          timeIndicators.length > 0 && i % 5 == 0);
    }
  }

  void _drawTime(Canvas canvas, Size size, int time) {
    textPainter.text = TextSpan(
      text: '$time',
      style: textStyle,
    );

    textPainter.layout();

    textPainter.paint(
        canvas, Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
  }

  void _drawTimes(Canvas canvas, Size size) {
    double angle = 2 * math.pi / timeIndicators.length;
    canvas.rotate(angle);
    for (int i = 0; i < timeIndicators.length; i++) {
      canvas.save();
      canvas.translate(0.0, -dialRadius + 10);

      _drawTime(canvas, size, timeIndicators.elementAt(i));

      canvas.restore();
      canvas.rotate(angle);
    }
  }

  @override
  bool shouldRepaint(_DialPainter oldDelegate) {
    return false;
  }
}
