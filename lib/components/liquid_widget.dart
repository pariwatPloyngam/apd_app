// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, camel_case_types

import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

double calDrainProgress(int prog, int target) {
  if (prog.isNaN) prog = 0;
  if (target.isNaN) target = 0;
  int cal = (target - prog);
  double progress = cal / target;
  if (progress > 1.0) progress = 1.0;
  if (progress.isNaN) progress = 0.0;
  return progress;
}

double calFillProgress(int prog, int target) {
  if (prog.isNaN) prog = 0;
  if (target.isNaN) target = 0;
  double progress = (prog / target);
  if (progress > 1.0) progress = 1.0;
  if (progress.isNaN) progress = 0.0;
  return progress;
}

// int calFlowRate(int prog) {
//   if (prog.isNaN) prog = 0;

//   Timer.periodic(Duration(seconds: 1), (timer) {
//     int timers = timer.tick;
//     print('TIMERS $timers');
//   });
//   int frowrate = 0;

//   return frowrate;
// }

class DrainIndicator extends StatefulWidget {
  const DrainIndicator({
    Key? key,
  }) : super(key: key);
  @override
  State<DrainIndicator> createState() => _DrainIndicatorState();
}

class _DrainIndicatorState extends State<DrainIndicator> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    final progress = calDrainProgress(provider.progress, provider.target);
    // final flowrate = calFlowRate(provider.progress);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 210,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('ระบายออกเเล้ว',
                            style: TextStyle(
                                fontSize: 32, color: AppColor.textDark1)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            provider.progress < 0
                                ? '0/'
                                : '${provider.progress}/',
                            style: TextStyle(
                                fontSize: 32, color: AppColor.darkWidget)),
                        Text('${provider.target} ',
                            style: TextStyle(
                                fontSize: 26, color: AppColor.darkWidget)),
                        Text('มล.',
                            style: TextStyle(
                                fontSize: 26, color: AppColor.textDark1))
                      ],
                    ),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('กำไร',
                //         style:
                //             TextStyle(fontSize: 30, color: AppColor.textDark1)),
                //     Text(' 25 ',
                //         style: TextStyle(
                //             fontSize: 30, color: AppColor.darkWidget)),
                //     Text('มล.',
                //         style:
                //             TextStyle(fontSize: 30, color: AppColor.textDark1))
                //   ],
                // ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 10),
                //       child: Text('10',
                //           style: TextStyle(
                //               fontSize: 30,
                //               color: AppColor.darkWidget,
                //               fontWeight: FontWeight.bold)),
                //     ),
                //     Text('  มล/วินาที',
                //         style: TextStyle(
                //             fontSize: 30,
                //             color: AppColor.textDark1,
                //             fontWeight: FontWeight.bold))
                //   ],
                // )
              ],
            ),
          ),
          SizedBox(
            height: 180,
            width: 180,
            child: LiquidCircularProgressIndicator(
              borderColor: Colors.transparent,
              borderWidth: 0,
              value: progress,
              direction: Axis.vertical,
              backgroundColor: Colors.white10,
              valueColor:
                  AlwaysStoppedAnimation(AppColor.darkWidget.withBlue(200)),
              center: Container(
                // height: 150,
                child: SvgPicture.asset(
                  'assets/svg/kidneys.svg',
                  height: 130,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.white.withOpacity(.7),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FillIndicator extends StatefulWidget {
  const FillIndicator({
    Key? key,
  }) : super(key: key);

  @override
  State<FillIndicator> createState() => _FillIndicatorState();
}

class _FillIndicatorState extends State<FillIndicator> {
  int percent = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    final progress = calFillProgress(provider.progress, provider.target);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('กำลังเติมเข้า',
                              style: TextStyle(
                                  fontSize: 32, color: AppColor.textDark1)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${provider.progress}/',
                              style: TextStyle(
                                  fontSize: 32, color: AppColor.textDark1)),
                          Text('${provider.target - 25} ',
                              style: TextStyle(
                                  fontSize: 26, color: AppColor.textDark1)),
                          Text('มล.',
                              style: TextStyle(
                                  fontSize: 26, color: AppColor.textDark1))
                        ],
                      ),
                    ],
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('กำไร',
                  //         style: TextStyle(
                  //             fontSize: 30, color: AppColor.textDark1)),
                  //     Text(' 25 ',
                  //         style: TextStyle(
                  //             fontSize: 30, color: AppColor.darkWidget)),
                  //     Text('มล.',
                  //         style: TextStyle(
                  //             fontSize: 30, color: AppColor.textDark1))
                  //   ],
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 180,
              width: 180,
              child: LiquidCircularProgressIndicator(
                borderColor: Colors.transparent,
                borderWidth: 0,
                value: progress,
                direction: Axis.vertical,
                backgroundColor: Colors.white10,
                valueColor:
                    AlwaysStoppedAnimation(AppColor.darkWidget.withBlue(200)),
                center: Container(
                  // height: 150,
                  child: SvgPicture.asset(
                    'assets/svg/kidneys.svg',
                    height: 130,
                    allowDrawingOutsideViewBox: true,
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
              ),
            ),
          ],
        )
        //   ],
        // ),
        );
  }
}

class DwellIndicator extends StatelessWidget {
  const DwellIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('กำลังเเช่น้ำยา',
                style: TextStyle(fontSize: 32, color: AppColor.textDark1)),
          ),
          Stack(
            children: [
              SizedBox(
                height: 180,
                width: 180,
                child: LiquidCircularProgressIndicator(
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  value: 100,
                  direction: Axis.vertical,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation(
                      AppColor.darkWidget.withBlue(200).withOpacity(.7)),
                  center: Container(
                    // height: 150,
                    child: SvgPicture.asset(
                      'assets/svg/kidneys.svg',
                      height: 130,
                      allowDrawingOutsideViewBox: true,
                      color: Colors.white.withOpacity(.7),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 180,
                  width: 180,
                  child: Lottie.asset(
                    'assets/animation/dwell_animation.json',
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class SuccessIndicator extends StatelessWidget {
  const SuccessIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
          width: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('เสร็จสิ้น',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkWidget))
            ],
          )),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           'ดำเนินการ',
      //           style: TextStyle(fontSize: 30),
      //         ),
      //         Text('เสร็จสิ้น',
      //             style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      //       ],
      //     ),
      //     SizedBox(
      //       height: 200,
      //       width: 200,
      //       child: LiquidCircularProgressIndicator(
      //         borderColor: Colors.transparent,
      //         borderWidth: 0,
      //         value: 100,
      //         direction: Axis.vertical,
      //         backgroundColor: Theme.of(context).appBarTheme.shadowColor,
      //         valueColor: AlwaysStoppedAnimation(
      //             Theme.of(context).canvasColor.withOpacity(.7)),
      //         center: Container(
      //           // height: 150,
      //           child: SvgPicture.asset(
      //             'assets/svg/kidneys.svg',
      //             height: 150,
      //             allowDrawingOutsideViewBox: true,
      //             color: Colors.white.withOpacity(.7),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
