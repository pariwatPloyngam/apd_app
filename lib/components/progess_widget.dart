// ignore_for_file: prefer_const_constructors

import 'package:apd_app/components/clock_widget.dart';
import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:svg_icon/svg_icon.dart';

double calProgress(int prog, int target) {
  if (prog.isNaN) prog = 0;
  if (target.isNaN) target = 0;
  double progress = (prog / target);
  if (progress > 1.0) progress = 1.0;
  if (progress.isNaN) progress = 0.0;
  return progress;
}

class DrainWidget extends StatefulWidget {
  const DrainWidget({
    super.key,
  });

  @override
  State<DrainWidget> createState() => _DrainWidgetState();
}

class _DrainWidgetState extends State<DrainWidget> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<APDSystemProvider>(context, listen: false);
    final progress = calProgress(data.progress, data.target);
    final percent = (progress * 100).toStringAsFixed(0);

    // final target =
    // Provider.of<APDSystemProvider>(context, listen: false).target;

    return CircularPercentIndicator(
      percent: progress,
      animation: true,
      animationDuration: 3000,
      animateFromLastPercent: true,
      radius: 150,
      lineWidth: 30,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.white.withOpacity(.2),
      // progressColor: AppColor.darkWidget,
      linearGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
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
            style: TextStyle(
              color: AppColor.textDark1,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$percent %',
            style: TextStyle(
              color: AppColor.darkWidget,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text(
          //   '${data.progress.toStringAsFixed(0)}/${data.target.toStringAsFixed(0)} .ml',
          //   style: TextStyle(
          //     color: AppColor.textDark1,
          //     fontSize: 32,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class FillWidget extends StatefulWidget {
  const FillWidget({
    super.key,
  });

  @override
  State<FillWidget> createState() => _FillWidgetState();
}

class _FillWidgetState extends State<FillWidget> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<APDSystemProvider>(context, listen: false);
    final progress = calProgress(data.progress, data.target);
    final percent = (progress * 100).toStringAsFixed(0);

    // final target =
    // Provider.of<APDSystemProvider>(context, listen: false).target;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularPercentIndicator(
          percent: progress,
          animation: true,
          animationDuration: 3000,
          animateFromLastPercent: true,
          radius: 150,
          lineWidth: 30,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.white.withOpacity(.2),
          // progressColor: AppColor.darkWidget,
          linearGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
                style: TextStyle(
                  color: AppColor.textDark1,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$percent %',
                style: TextStyle(
                  color: AppColor.darkWidget,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Dwell extends StatelessWidget {
  const Dwell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<APDSystemProvider>(context, listen: false);

    return SizedBox(
      width: 300,
      height: 300,
      child: LiquidCircularProgressIndicator(
        value: .8,
        backgroundColor: Colors.white10,
        valueColor: AlwaysStoppedAnimation(
            AppColor.darkWidget.withOpacity(.9).withBlue(200)),
        center: SvgIcon(
          'assets/svg/kidneys.svg',
          width: 200,
          height: 200,
          color: Colors.white54,
        ),
      ),
    );
  }
}

class None extends StatelessWidget {
  const None({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 400,
            height: 400,
            child: CircularPercentIndicator(
              radius: 200,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: OverallTime(),
        )
      ],
    );
  }
}
