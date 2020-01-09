import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dial.dart';
import 'gear.dart';
import 'hand.dart';

class Clock extends StatelessWidget {
  final Color gearColor;
  final Color gearToothColor;
  final double gearRadius;

  final int gearTeethNumber;
  final double gearTeethWidth;

  final Color dialColor;
  final Color dialTickColor;

  final int dialTickNumber;

  final double tickNumber;
  final List<int> dialTimeIndicators;
  final Color handColor;

  final double handWidth;

  final double handRotationAngle;

  const Clock({Key key,
    this.gearColor = const Color(0xffF2D7AE),
    this.gearToothColor = const Color(0xffA18D7F),
    this.gearRadius = 60.0,
    this.gearTeethNumber = 60,
    this.gearTeethWidth = 2.0,
    this.dialColor = const Color(0xff658DC6),
    this.dialTickColor = const Color(0xffB5C7D4),
    this.dialTickNumber = 60,

    this.tickNumber = 60,
    this.dialTimeIndicators = const [],
    this.handColor = const Color(0xffA18D7F),

    this.handWidth = 6,
    @required this.handRotationAngle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Gear(
          gearColor: gearColor,
          gearRadius: gearRadius,
          gearWidth: gearRadius /2,
          teethColor: gearToothColor,
          teethNumber: gearTeethNumber,
          teethWidth: gearTeethWidth,
          toothSize: gearRadius + gearRadius/2,
        ),
        Dial(
          dialWidth:  gearRadius/2,
          dialRadius: gearRadius + gearRadius/2,
          tickNumber: dialTickNumber,
          dialColor: dialColor,
          tickColor: dialTickColor,
          timeIndicators: dialTimeIndicators,
          timeIndicatorsSize: gearRadius /4,
          tickSize: gearRadius/20,
        ),
        Hand(
          handAngle: handRotationAngle,
          handColor: handColor,
          handLength: gearRadius + gearRadius/2,
          handWidth: handWidth,
        )
      ],
    );;
  }

}

