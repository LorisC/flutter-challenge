import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_analog_clock/rotor.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'dart:math' as math;
import 'clock.dart';
import 'dial.dart';
import 'gear.dart';
import 'hand.dart';

void main() => runApp(MyApp());
final radiansPerTick = radians(360 / 60);
final radiansPerHour = radians(360 / 12);


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double angle = 0;
  DateTime _now = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(microseconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff84898C),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Clock(
                  handRotationAngle: _now.hour * radiansPerHour+
                  (_now.minute / 60) * radiansPerHour,
                  dialTimeIndicators: [3,6,9,12],
                ),
              ),
              Container(
                child: Clock(
                  handColor: Color(0xffF2D7AE),
                  dialColor: Color(0xffB5C7D4),
                  gearColor: Color(0xffF5B895),
                  gearToothColor: Color(0xffB5C7D4),
                  dialTickColor: Color(0xff0F4C81),
                  handRotationAngle: _now.minute * radiansPerTick,
                  dialTimeIndicators: [10,20,30,40,50,0],
                ),
              ),
              Container(

                child: Clock(
                  gearRadius: 20,
                  handColor: Color(0xffF5B895),
                  dialColor: Color(0xffA18D7F),
                  gearColor: Color(0xffB5C7D4),
                  dialTickColor: Color(0xff0F4C81),
                  gearToothColor: Color(0xff0F4C81),
                  handRotationAngle: _now.second * radiansPerTick,
                  dialTimeIndicators: [5,10,15,20,25,30,35,40,45,50,55,0],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



/*
*   Gear(
              gearColor: Colors.red,
              gearRadius: 60.0,
              gearWidth: 30.0,
              teethColor: Colors.amber,
              teethNumber: 60,
              teethWidth: 2.0,
              toothSize: 90,
            ),
            Dial(
              dialWidth: 30,
              dialRadius: 90,
              tickNumber: 60,
              dialColor: Colors.blue,
              tickColor: Colors.black,
              numberOfTimeIndicator: 12,
            ),
            Hand(
              handAngle: 90,
              handColor: Colors.green,
              handLength: 90,
              handWidth: 2,
            )
            * */
