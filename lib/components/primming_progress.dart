// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class PrimmingIndicator extends StatefulWidget {
  const PrimmingIndicator({super.key});

  @override
  State<PrimmingIndicator> createState() => _PrimmingIndicatorState();
}

class _PrimmingIndicatorState extends State<PrimmingIndicator> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<APDSystemProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
        child: Center(
            child: Container(
          child: CircularPercentIndicator(
            radius: 250,
            // percent: provider.primDone == false ? 0 : 1,
            percent: provider.primProgress,
            lineWidth: 40,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.darkWidget,
                AppColor.darkWidget.withBlue(220),
              ],
            ),
            backgroundColor: Colors.white10,
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animateFromLastPercent: true,
            animationDuration: 500,
            // onAnimationEnd: () {
            //   provider.onprimming = false;
            //   // Navigator.of(context).push(
            //   //   MaterialPageRoute(builder: (context) => ConnectPatientLine()
            //   //       // SystemInitPage(),
            //   //       // MonitorPage()
            //   //       ),
            //   // );
            //   // provider.primDone == true
            //   //     ? Navigator.of(context).push(
            //   //         MaterialPageRoute(builder: (context) => SlideScreen2()
            //   //             // SystemInitPage(),
            //   //             // MonitorPage()
            //   //             ),
            //   //       )
            //   //     : null;
            // },
            center: Text(
              'กำลังไล่อากาศในระบบ..',
              style: TextStyle(fontSize: 30, color: AppColor.textDark1),
            ),
          ),
        )),
      ),
    );
  }
}
