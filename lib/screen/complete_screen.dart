// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/screen/user_guide.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  bool isLoading = true;
  bool lessHour = false;
  bool dwellLessHour = false;
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    provider.alertState = AlertState.NONE;
    Future.delayed(Duration(seconds: 7), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  String calculateTime(int timer) {
    Duration duration = Duration(seconds: timer);
    String formattedTime;

    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);

    if (hours > 0) {
      formattedTime =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      formattedTime =
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      setState(() {
        lessHour = true;
      });
    }

    return formattedTime ;
  }

  String calculateDwellTime() {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    double timer = provider.target / provider.totalCycle;

    Duration duration = Duration(seconds: timer.toInt());
    String formattedTime;

    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);

    if (hours > 0) {
      formattedTime =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      formattedTime =
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      setState(() {
        dwellLessHour = true;
      });
    }

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final totalTimes = calculateTime(provider.totalTime);
    return Scaffold(
      body: Container(
          width: width,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops: [0.0, 1.0],
                  colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
          child: isLoading == true
              ? Center(
                  child: Lottie.asset('assets/animation/success_animation.json',
                      repeat: false),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        // color: Colors.white10,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 90,
                          decoration: BoxDecoration(
                              // color: Colors.white10,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 15),
                                width: 350,
                                height: 90,
                                decoration: BoxDecoration(
                                    // color: Colors.green[100]
                                    ),
                                child: Text(
                                  'สรุปผลการล้างไต',
                                  style: TextStyle(
                                      fontSize: 46,
                                      color: AppColor.darkWidget,
                                      ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 90,
                                decoration: BoxDecoration(
                                    // color: Colors.green[200]
                                    ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 50),
                                alignment: Alignment.topRight,
                                width: 350,
                                height: 90,
                                decoration: BoxDecoration(
                                    // color: Colors.green[300]
                                    ),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.play_arrow_rounded,
                                      size: 70,
                                      color: AppColor.textDark1,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Guide2()),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 560,
                          decoration: BoxDecoration(
                              // color: Colors.white10,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                width: 580,
                                height: 560,
                                // decoration:
                                //     BoxDecoration(color: Colors.green[200]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 300,
                                            height: 100,
                                            // color: Colors.green,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ปริมาณน้ำยาที่ใช้',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'ปริมาณน้ำยาทั้งหมดที่ใช้ในการล้างไต',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${provider.totalVol}',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'มิลลิตร',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 330,
                                            height: 100,
                                            // color: Colors.green,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ปริมาณของเสียทิ้ง',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'ปริมาณของเสียที่ทิ้งแต่ละรอบ ${provider.drainVol} มล.',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${provider.totalDrainVol - provider.idrainVol}',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'มิลลิตร',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 330,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ปริมาณน้ำยาที่เติมเข้า',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  'ปริมาณน้ำยาที่เติมเข้ารอบละ ${provider.fillVol} มล.',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${provider.totalFillVol}',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'มิลลิตร',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 330,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ปริมาณของเสียค้างท้อง',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '( I-Drain )',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider.idrainVol == 0
                                                      ? '-'
                                                      : '${provider.idrainVol}',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'มิลลิตร',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 330,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ระยะเวลาแช่เฉลี่ย',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '( Dwell Time )',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  calculateDwellTime(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  dwellLessHour == false
                                                      ? 'นาที'
                                                      : 'ชั่วโมง',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // VerticalDivider(
                              //   color: AppColor.textDark1.withOpacity(.2),
                              //   thickness: 2,
                              //   indent: 30,
                              //   endIndent: 30,
                              // ),
                              Container(
                                padding: EdgeInsets.all(15),
                                width: 580,
                                height: 560,
                                // decoration:
                                //     BoxDecoration(color: Colors.green[200]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 330,
                                            height: 100,
                                            // color: Colors.black,

                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'จำนวนรอบที่ใช้',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${provider.totalCycle}',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'รอบ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 330,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'เวลาที่ใช้ทั้งหมด',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  totalTimes,
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  lessHour == false
                                                      ? 'ชั่วโมง'
                                                      : 'นาที',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 330,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'กำไรทั้งหมด',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${provider.profit}',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'มิลลิตร',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 330,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ปริมาณน้ำยาที่เติมทิ้งไว้',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '( Last Fill )',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          // VerticalDivider(
                                          //   color: Colors.white,
                                          //   thickness: .5,
                                          //   indent: 10,
                                          //   endIndent: 25,
                                          //   width: 1,
                                          // ),
                                          Container(
                                            width: 185,
                                            height: 100,
                                            // color: Colors.black,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider.lastFillVol == 0
                                                      ? '-'
                                                      : '${provider.fillVol}',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'มิลลิตร',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: .5,
                                              color: AppColor.darkWidget),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          gradient: LinearGradient(
                                              begin: FractionalOffset.topCenter,
                                              end:
                                                  FractionalOffset.bottomCenter,
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              colors: [
                                                Colors.transparent,
                                                Colors.white.withOpacity(.05)
                                              ])),
                                      width: 550,
                                      height: 100,
                                      // child: Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Container(
                                      //       width: 300,
                                      //       height: 100,
                                      //       // color: Colors.black,
                                      //       child: Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.start,
                                      //         children: [
                                      //           Text(
                                      //             'ปริมาณน้ำยาที่เติมทิ้งไว้',
                                      //             style: TextStyle(
                                      //                 fontSize: 30,
                                      //                 color: Colors.white),
                                      //           ),
                                      //           Text(
                                      //             '( Last Fill )',
                                      //             style: TextStyle(
                                      //                 fontSize: 20,
                                      //                 color: Colors.white),
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     // VerticalDivider(
                                      //     //   color: Colors.white,
                                      //     //   thickness: .5,
                                      //     //   indent: 10,
                                      //     //   endIndent: 25,
                                      //     //   width: 1,
                                      //     // ),
                                      //     Container(
                                      //       width: 185,
                                      //       height: 100,
                                      //       // color: Colors.black,
                                      //       child: Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.end,
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.start,
                                      //         children: [
                                      //           Text(
                                      //             provider.lastFillVol == 0
                                      //                 ? '-'
                                      //                 : '${provider.fillVol}',
                                      //             style: TextStyle(
                                      //                 fontSize: 30,
                                      //                 color:
                                      //                     AppColor.darkWidget,
                                      //                 fontWeight:
                                      //                     FontWeight.bold),
                                      //           ),
                                      //           Text(
                                      //             'มิลลิตร',
                                      //             style: TextStyle(
                                      //                 fontSize: 20,
                                      //                 color: Colors.white),
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(bottom: 10),
                    //       child: Container(
                    //         padding: EdgeInsets.only(right: 20),
                    //         width: 1100,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               'สรุปผล',
                    //               style: TextStyle(
                    //                 color: AppColor.darkWidget,
                    //                 fontSize: 60,
                    //               ),
                    //             ),
                    //             IconButton(
                    //                 onPressed: () {
                    //                   Navigator.of(context).push(
                    //                     MaterialPageRoute(
                    //                         builder: (context) => Guide2()),
                    //                   );
                    //                 },
                    //                 icon: Icon(
                    //                   Icons.exit_to_app_rounded,
                    //                   size: 50,
                    //                   color: AppColor.textDark1,
                    //                 ))
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: 1100,
                    //       height: 150,
                    //       decoration: BoxDecoration(
                    //           color: Colors.white.withOpacity(.05),
                    //           borderRadius: BorderRadius.circular(16)),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Container(
                    //             padding: EdgeInsets.only(
                    //                 top: 15, left: 50),
                    //             width: 330,
                    //             height: 150,
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'ปริมาณน้ำยาทั้งหมด',
                    //                   style: TextStyle(
                    //                       color: AppColor.textDark1,
                    //                       fontSize: 22),
                    //                 ),
                    //                 Row(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.center,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Container(
                    //                       alignment: Alignment.centerRight,
                    //                       width: 100,
                    //                       height: 50,
                    //                       // color: Colors.black,
                    //                       child: Text(
                    //                         '1234',
                    //                         style: TextStyle(
                    //                             color: AppColor.darkWidget,
                    //                             fontSize: 36,
                    //                             fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ),
                    //                     Container(
                    //                       alignment: Alignment.centerRight,
                    //                       width: 80,
                    //                       height: 50,
                    //                       // color: Colors.grey,
                    //                       child: Text('มล.',
                    //                           style: TextStyle(
                    //                               color: AppColor.textDark1,
                    //                               fontSize: 34)),
                    //                     ),
                    //                     Container(
                    //                       width: 50,
                    //                       height: 50,
                    //                       // color: Colors.black,
                    //                     )
                    //                   ],
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //           VerticalDivider(
                    //             color: AppColor.textDark1.withOpacity(.2),
                    //             thickness: 2,
                    //             indent: 30,
                    //             endIndent: 30,
                    //           ),
                    //           Container(
                    //             color: Colors.amber,
                    //             width: 330,
                    //             height: 150,
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'เวลาที่ใช้ทั้งหมด',
                    //                   style: TextStyle(
                    //                       color: AppColor.textDark1,
                    //                       fontSize: 24),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 Row(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       '02.00.00',
                    //                       style: TextStyle(
                    //                           color: AppColor.darkWidget,
                    //                           fontSize: 40,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                     Text('ชม.',
                    //                         style: TextStyle(
                    //                             color: AppColor.textDark1,
                    //                             fontSize: 34))
                    //                   ],
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //           VerticalDivider(
                    //             color: AppColor.textDark1.withOpacity(.2),
                    //             thickness: 2,
                    //             indent: 30,
                    //             endIndent: 30,
                    //           ),
                    //           Container(
                    //             color: Colors.black,
                    //             width: 330,
                    //             height: 150,
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'รอบที่ใช้',
                    //                   style: TextStyle(
                    //                       color: AppColor.textDark1,
                    //                       fontSize: 24),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 Row(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       '5',
                    //                       style: TextStyle(
                    //                           color: AppColor.darkWidget,
                    //                           fontSize: 40,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                     Text('รอบ',
                    //                         style: TextStyle(
                    //                             color: AppColor.textDark1,
                    //                             fontSize: 34))
                    //                   ],
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 10),
                    //       child: Container(
                    //         width: 1100,
                    //         height: 400,
                    //         decoration: BoxDecoration(
                    //             color: Colors.white.withOpacity(.05),
                    //             borderRadius: BorderRadius.circular(16)),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ),
                )),
    );
  }
}

// import 'dart:developer';

// import 'package:apd_app/components/chart.dart';
// import 'package:apd_app/styles/color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:provider/provider.dart';

// class CompleteScreen extends StatefulWidget {
//   const CompleteScreen({Key? key}) : super(key: key);

//   @override
//   State<CompleteScreen> createState() => _CompleteScreenState();
// }

// class _CompleteScreenState extends State<CompleteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     int cycles = 4;
//     return Scaffold(
//         body: Container(
//       width: width,
//       height: height,
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: FractionalOffset.topCenter,
//               end: FractionalOffset.bottomCenter,
//               stops: [0.0, 1.0],
//               colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 80),
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             color:
//                 Theme.of(context).appBarTheme.backgroundColor?.withOpacity(.0),
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//           ),
//           child: Column(
//             children: [
//               Text(
//                 'สรุปผล',
//                 style: TextStyle(fontSize: 32, color: AppColor.darkWidget),
//               ),
//               Expanded(child: Report1(cycles: cycles)),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

// class Report1 extends StatelessWidget {
//   const Report1({
//     Key? key,
//     required this.cycles,
//   }) : super(key: key);

//   final int cycles;

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Padding(
//         padding: const EdgeInsets.all(20),
//         child: Container(
//           height: 350,
//           decoration: BoxDecoration(
//               color: Colors.white10,
//               borderRadius: BorderRadius.circular(16)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 350,
//                 width: 400,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'ข้อมูลทั้งหมด',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget),
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'ปริมาณน้ำยาทิ้ง ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)
//                                     ),
//                                     Text(
//                                       'ปริมาณน้ำยาที่เติมเข้า ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget),
//                                     ),
//                                     Text(
//                                       'กำไรสะสม ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget),
//                                     ),
//                                     Text(
//                                       'จำนวนรอบ ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget),
//                                     ),
//                                     Text(
//                                       'ใช้เวลาทั้งสิ้น ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(' 2400 ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                         Text(' มล.',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(' 2000 ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                         Text(' มล.',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(' 400 ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                         Text(' มล.',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(' ${cycles} ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                         Text(' รอบ.',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(' 04.00 ',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                         Text(' ชม.',
//                             style: TextStyle(fontSize: 24, color: AppColor.darkWidget)),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 350,
//                 width: 550,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       'กำไรเปรียบเทียบ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)
//                     ),
//                     LineChartSample2(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       Flexible(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
//           child: ListView.builder(
//               physics: BouncingScrollPhysics(),
//               scrollDirection: Axis.horizontal,
//               itemCount: cycles,
//               itemBuilder: ((BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 16, bottom: 8),
//                   child: Container(
//                     height: 300,
//                     width: 350,
//                     decoration: BoxDecoration(
//                         color:
//                            Colors.white10,
//                         borderRadius: BorderRadius.circular(16)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'ข้อมูลรอบที่ ' + ' ${index + 1}',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget),
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'ปริมาณน้ำยาทิ้ง ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget),
//                                     ),
//                                     Text(
//                                       'ปริมาณน้ำยาที่เติมเข้า ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget),
//                                     ),
//                                     Text(
//                                       'กำไร ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget),
//                                     ),
//                                     Text(
//                                       'ใช้เวลา ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(' 2400 ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)),
//                                         Text(' มล.',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(' 2000 ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)),
//                                         Text(' มล.',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(' 400 ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)),
//                                         Text(' มล.',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(' 04.00 ',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)),
//                                         Text(' ชม.',
//                             style: TextStyle(fontSize: 28, color: AppColor.darkWidget)),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               })),
//         ),
//       )
//     ]);
//   }
// }


// import 'package:flutter/material.dart';

// class CompleteScreen extends StatelessWidget {
//   const CompleteScreen({
//     Key? key,
   
//   }) : super(key: key);



//   @override
//   Widget build(BuildContext context) {
//     // ignore: unnecessary_null_comparison

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [
//               0.0,
//               1.0
//             ],
//                 colors: [
//               Theme.of(context).colorScheme.secondary,
//               Theme.of(context).colorScheme.tertiary
//             ])),
//         padding: EdgeInsets.only(top: 0),
//         alignment: Alignment.center,
//         child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
//           Column(
//             children: [
//               Expanded(
//                   child: Container(
//                 child: SingleChildScrollView(
//                     physics: BouncingScrollPhysics(),
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: MediaQuery.of(context).size.width / 7,
//                               right: 32,
//                               top: 10,
//                               bottom: 200),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width / 4,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             right: BorderSide(
//                                       width: 3.0,
//                                       color: Theme.of(context).backgroundColor,
//                                     ))),
//                                     child: Column(children: [
//                                       Text(
//                                           '0000',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(
//                                                   fontSize: 64,
//                                                   fontWeight: FontWeight.bold)),
//                                       Text('มิลลิลิตร',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(fontSize: 26))
//                                     ]),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 4 * 2,
//                                     decoration: BoxDecoration(),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 50.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('น้ำยาทิ้งเริ่มต้น (IDRAIN)',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                           Text(
//                                               'ปริมาณมาณน้ำยาทั้งหมดที่ใช้ในการล้างไต',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(fontSize: 20))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width / 4,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             right: BorderSide(
//                                       width: 3.0,
//                                       color: Theme.of(context).backgroundColor,
//                                     ))),
//                                     child: Column(children: [
//                                       Text('0000}',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(
//                                                   fontSize: 64,
//                                                   fontWeight: FontWeight.bold)),
//                                       Text('มิลลิลิตร',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(fontSize: 26))
//                                     ]),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 4 * 2,
//                                     decoration: BoxDecoration(),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 50.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('ปริมาณทั้งหมด (TOTAL SOLUTION)',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                           Text(
//                                               'ปริมาณมาณน้ำยาทั้งหมดที่ใช้ในการล้างไต',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(fontSize: 20))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width / 4,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             right: BorderSide(
//                                       width: 3.0,
//                                       color: Theme.of(context).backgroundColor,
//                                     ))),
//                                     child: Column(children: [
//                                       Text(
//                                           '0000',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(
//                                                   fontSize: 64,
//                                                   fontWeight: FontWeight.bold)),
//                                       Text('รอบ',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(fontSize: 26))
//                                     ]),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 4 * 2,
//                                     decoration: BoxDecoration(),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 50.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('จำนวนรอบ (NUMBER CYCLE)',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                           Text(
//                                               'จำนวนรอบในการล้างไตที่ใช้น้ำยาล้างไตทั้งหมด 0000 มล.\nรอบละ 0000 มล.',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(fontSize: 20))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width / 4,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             right: BorderSide(
//                                       width: 3.0,
//                                       color: Theme.of(context).backgroundColor,
//                                     ))),
//                                     child: Column(children: [
//                                       Text(
//                                           '0000 : 0000 % 60}',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(
//                                                   fontSize: 64,
//                                                   fontWeight: FontWeight.bold)),
//                                       Text('ชั่วโมง:นาที',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(fontSize: 26))
//                                     ]),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 4 * 2,
//                                     decoration: BoxDecoration(),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 50.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('ระยะเวลา (TOTAL TIME)',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                           Text('เวลาที่ใช้ในการล้างไตทั้งทั้งหมด',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(fontSize: 20))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width / 4,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             right: BorderSide(
//                                       width: 3.0,
//                                       color: Theme.of(context).backgroundColor,
//                                     ))),
//                                     child: Column(children: [
//                                       Text('0000',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(
//                                                   fontSize: 64,
//                                                   fontWeight: FontWeight.bold)),
//                                       Text('มิลลิลิตร',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(fontSize: 26))
//                                     ]),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 4 * 2,
//                                     decoration: BoxDecoration(),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 50.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('การเติมน้ำยา (FILL)',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                           Text('ปริมาณน้ำนาที่ใช้ล้างไตต่อรอบ',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(fontSize: 20))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width / 4,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             right: BorderSide(
//                                       width: 3.0,
//                                       color: Theme.of(context).backgroundColor,
//                                     ))),
//                                     child: Column(children: [
//                                       Text(
//                                           '0000',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(
//                                                   fontSize: 64,
//                                                   fontWeight: FontWeight.bold)),
//                                       Text('มิลลิลิตร',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(fontSize: 26))
//                                     ]),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 4 * 2,
//                                     decoration: BoxDecoration(),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 50.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('ปริมาณน้ำยาที่แช่ (LAST FILL)',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                           Text(
//                                               'ปริมาณน้ำยาพิเศษที่ใช้แช่ระหว่างวัน',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(fontSize: 20))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: MediaQuery.of(context).size.width / 4,
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             right: BorderSide(
//                                       width: 3.0,
//                                       color: Theme.of(context).backgroundColor,
//                                     ))),
//                                     child: Column(children: [
//                                       Text(
//                                           'same',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1
//                                               ?.copyWith(
//                                                   fontSize: 64,
//                                                   fontWeight: FontWeight.bold)),
//                                       Text('',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .labelLarge)
//                                     ]),
//                                   ),
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width / 4 * 2,
//                                     decoration: BoxDecoration(),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 50.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('Dextrose'.toUpperCase(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                           Text('น้ำยาพิเศษที่ใช้แช่ระหว่างวัน',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1
//                                                   ?.copyWith(fontSize: 20))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     )),
//               )),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }