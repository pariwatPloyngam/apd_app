import 'dart:async';

import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OtpTimer extends StatefulWidget {
  @override
  _OtpTimerState createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ (60 * 60)).toString().padLeft(2, '0')}.${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}.${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(timerText,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            ?.copyWith(fontSize: 40, fontWeight: FontWeight.bold));
  }
}

class TimeCo extends StatefulWidget {
  const TimeCo({Key? key}) : super(key: key);

  @override
  State<TimeCo> createState() => _TimeCoState();
}

class _TimeCoState extends State<TimeCo> {
  final interval = const Duration(seconds: 1);
  int percent = 0;
  int timers = 300;

  String get timerText =>
      '${(timers ~/ (60 * 60)).toString().padLeft(2, '0')}.${(timers ~/ 60).toString().padLeft(2, '0')}.${(timers % 60).toString().padLeft(2, '0')}';

  startTime([milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      
        timers = timer.tick;
        if (percent >= 99) {
          timer.cancel();
        }
      });
    
  }

  @override
  void initState() {
    startTime();
    // Timer timer;
    // timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   setState(() {
    //     percent += 1;
    //     if (percent >= 100) {
    //       timer.cancel();
    //     }
    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        timerText,
        style: TextStyle(fontSize: 32, color: AppColor.textDark1),
      ),
    );
  }
}


class OverallTime extends StatelessWidget {
  const OverallTime({
    super.key,
  });

  String calculateTime(int timer) {
    Duration duration = Duration(seconds: timer);
  int hours = duration.inHours;
  int minutes = (duration.inMinutes % 60);
  int seconds = (duration.inSeconds % 60);

  String formattedTime =
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

  return formattedTime;
    
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<APDSystemProvider>(context, listen: false);
    final oat = calculateTime(data.totalTime);
    return Text(oat,
        style: TextStyle(fontSize: 38, color: AppColor.darkWidget, fontWeight: FontWeight.bold));
  }
}