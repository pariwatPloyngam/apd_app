// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

double calProgress(int prog, int target) {
  if (prog.isNaN) prog = 0;
  if (target.isNaN) target = 0;
  double progress = (prog / target);
  if (progress > 1.0) progress = 1.0;
  if (progress.isNaN) progress = 0.0;
  return progress;
}

class DrainProgress extends StatefulWidget {
  const DrainProgress({
    Key? key,
  }) : super(key: key);

  @override
  State<DrainProgress> createState() => _DrainProgressState();
}

class _DrainProgressState extends State<DrainProgress> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    final progress = calProgress(provider.progress, provider.target);
    final percent = (progress * 100).toStringAsFixed(0);
    return CircularPercentIndicator(
      radius: 200,
      lineWidth: 40,
      percent: progress < 0 ? 0 : progress,
      backgroundColor: Colors.white10,
      animation: true,
      animateFromLastPercent: true,
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColor.darkWidget,
          AppColor.darkWidget.withBlue(220),
        ],
      ),
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Draining',
            style: TextStyle(fontSize: 36, color: AppColor.textDark1),
          ),
          Text(percent + '%',
              style: TextStyle(
                  fontSize: 50,
                  color: AppColor.darkWidget,
                  fontWeight: FontWeight.bold)),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [

          //     Text('${provider.progress}/',
          //         style: TextStyle(fontSize: 36, color: AppColor.textDark1)),
          //     Text('${provider.target} ',
          //         style: TextStyle(fontSize: 30, color: AppColor.textDark1)),
          //     Text('มล.',
          //         style: TextStyle(fontSize: 30, color: AppColor.textDark1))
          //   ],
          // )
        ],
      ),
    );
  }
}

class FillProgress extends StatefulWidget {
  const FillProgress({
    Key? key,
  }) : super(key: key);

  @override
  State<FillProgress> createState() => _FillProgressState();
}

class _FillProgressState extends State<FillProgress> {
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    final progress = calProgress(provider.progress, provider.target);
    final percent = (progress * 100).toStringAsFixed(0);
    return CircularPercentIndicator(
      radius: 200,
      lineWidth: 40,
      percent: progress < 0 ? 0 : progress,
      backgroundColor: Colors.white10,
      animation: true,
      animateFromLastPercent: true,
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColor.darkWidget,
          AppColor.darkWidget.withBlue(220),
        ],
      ),
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Filling',
            style: TextStyle(fontSize: 36, color: AppColor.textDark1),
          ),
          Text('$percent %',
              style: TextStyle(
                  fontSize: 50,
                  color: AppColor.darkWidget,
                  fontWeight: FontWeight.bold)),
          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [

          //     Text('${provider.progress}/',
          //         style: TextStyle(fontSize: 36, color: AppColor.textDark1)),
          //     Text('${provider.target} ',
          //         style: TextStyle(fontSize: 30, color: AppColor.textDark1)),
          //     Text('มล.',
          //         style: TextStyle(fontSize: 30, color: AppColor.textDark1))
          //   ],
          // )
        ],
      ),
    );
  }
}

class DwellProgress extends StatefulWidget {
  const DwellProgress({
    Key? key,
  }) : super(key: key);

  @override
  State<DwellProgress> createState() => _DwellProgressState();
}

class _DwellProgressState extends State<DwellProgress> {
  String _getDwellTime() {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    if (APDState == APDState.DWELL) {
      provider.dwellTime += provider.target;
    }
    int timers = provider.target - provider.progress;
    String timerText =
        '${(timers ~/ (60 * 60)).toString().padLeft(2, '0')}.${(timers ~/ 60).toString().padLeft(2, '0')}.${(timers % 60).toString().padLeft(2, '0')}';
    return timerText;
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<APDSystemProvider>(context, listen: false);
    return CircularPercentIndicator(
      radius: 200,
      lineWidth: 40,
      percent: 1,
      animation: false,
      animateFromLastPercent: false,
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColor.darkWidget,
          AppColor.darkWidget.withBlue(220),
        ],
      ),
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Dwelling',
            style: TextStyle(fontSize: 36, color: AppColor.textDark1),
          ),
          Text(_getDwellTime(),
              style: TextStyle(fontSize: 40, color: AppColor.textDark1))
          // TimeCo()
          // Text(
          //   '01:59:35',
          //   style: TextStyle(fontSize: 50, color: AppColor.darkWidget),
          // ),
          // OtpTimer()
          // Text('00.00.00',
          //     style: Theme.of(context)
          //         .textTheme
          //         .bodyText2
          //         ?.copyWith(fontSize: 46, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class SuccesProgress extends StatefulWidget {
  const SuccesProgress({
    Key? key,
  }) : super(key: key);

  @override
  State<SuccesProgress> createState() => _SuccesProgressState();
}

class _SuccesProgressState extends State<SuccesProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/animation/success_animation.json',
          height: 400, width: 400, repeat: false),
    );
  }
}
