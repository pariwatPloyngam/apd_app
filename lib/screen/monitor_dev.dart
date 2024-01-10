// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:apd_app/components/clock_widget.dart';
import 'package:apd_app/components/progess_widget.dart';
import 'package:apd_app/components/program_info.dart';
import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:svg_icon/svg_icon.dart';

class MonitorDevPage extends StatefulWidget {
  @override
  State<MonitorDevPage> createState() => _MonitorDevPageState();
}

class _MonitorDevPageState extends State<MonitorDevPage> {
  bool openTemp = false;
  @override
  void dispose() {
    super.dispose();
  }

  String _getDwellTime() {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    int timers = provider.target - provider.progress;
    String timerText =
        '${(timers ~/ (60 * 60)).toString().padLeft(2, '0')}.${(timers ~/ 60).toString().padLeft(2, '0')}.${(timers % 60).toString().padLeft(2, '0')}';
    return timerText;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final provider = Provider.of<APDSystemProvider>(context, listen: false);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        width: width,
        height: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 800,
              width: 400,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white10),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'APD State : ${provider.apdState.name}',
                      style: TextStyle(fontSize: 30, color: AppColor.textDark1),
                    ),
                    buildProgressWidget(),
                    Column(
                      children: [
                        Text(
                          provider.apdState == APDState.DWELL
                              ? 'Dwell Times'
                              : 'Progress',
                          style: TextStyle(
                              fontSize: 30, color: AppColor.textDark1),
                        ),
                        Text(
                            provider.apdState == APDState.DWELL
                                ? _getDwellTime()
                                : '${provider.progress}/${provider.target - 25}',
                            style: TextStyle(
                                fontSize: 30,
                                color: AppColor.darkWidget,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 230,
                  width: 800,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white10),
                      borderRadius: BorderRadius.circular(12)),
                  child:
                      program_info(), ///////////////////////////////////////////////////////// PROGRAM INFORMATION/////////////////////////////////////////
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  height: 450,
                  width: 800,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white10),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          width: 800,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Data Streaming',
                                style: TextStyle(
                                    color: AppColor.textDark1, fontSize: 30),
                              ),
                              Container(
                                width: 250,
                                height: 70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Time',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: AppColor.textDark1),
                                    ),
                                    OverallTime(),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                width: 200,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 90,
                                      child: Text(
                                        'Cycles',
                                        style: TextStyle(
                                            color: AppColor.textDark1,
                                            fontSize: 26),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: 70,
                                      child: Text(
                                        '${provider.currentCycle} / ${provider.totalCycle}',
                                        style: TextStyle(
                                            color: AppColor.darkWidget,
                                            fontSize: 26),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Container(
                            //   padding: EdgeInsets.only(top: 10),
                            //   alignment: Alignment.bottomCenter,
                            //   width: 500,
                            //   height: 60,
                            //   // color: Colors.white10,
                            //   child: Row(
                            //     children: [
                            //       TextButton(
                            //           onPressed: () {},
                            //           child: Text(
                            //             'All',
                            //             style: TextStyle(
                            //                 fontSize: 24,
                            //                 color: AppColor.darkWidget,
                            //                 fontWeight: FontWeight.bold,
                            //                 decoration:
                            //                     TextDecoration.underline),
                            //           )),
                            //       TextButton(
                            //           onPressed: () {},
                            //           child: Text(
                            //             'Cycle 1',
                            //             style: TextStyle(
                            //                 fontSize: 22,
                            //                 color: AppColor.textDark1.withOpacity(.5)),
                            //           )),
                            //       TextButton(
                            //           onPressed: () {},
                            //           child: Text(
                            //             ' Cycle 2',
                            //             style: TextStyle(
                            //                 fontSize: 22,
                            //                 color: AppColor.textDark1.withOpacity(.5)),
                            //           )),
                            //       TextButton(
                            //           onPressed: () {},
                            //           child: Text(
                            //             'Cycle 3',
                            //             style: TextStyle(
                            //                 fontSize: 22,
                            //                 color: AppColor.textDark1.withOpacity(.5)),
                            //           ))
                            //     ],
                            //   ),
                            // ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 15),
                            //   width: 200,
                            //   height: 60,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       SizedBox(
                            //         width: 90,
                            //         child: Text(
                            //           'Cycles',
                            //           style: TextStyle(
                            //               color: AppColor.textDark1,
                            //               fontSize: 26),
                            //         ),
                            //       ),
                            //       Container(
                            //         alignment: Alignment.centerRight,
                            //         width: 70,
                            //         child: Text(
                            //           '${provider.currentCycle} / ${provider.totalCycle}',
                            //           style: TextStyle(
                            //               color: AppColor.darkWidget,
                            //               fontSize: 26),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 800,
                          height: 390,
                          // decoration: BoxDecoration(
                          //   border: Border.all(width: 1, color: Colors.white10),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: 250,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white10,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Solution Remaining',
                                          style: TextStyle(
                                              color: AppColor.textDark1,
                                              fontSize: 20),
                                        ),
                                        Container(
                                          // color: Colors.white12,
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                // color: Colors.white10,
                                                alignment:
                                                    Alignment.centerRight,
                                                height: 40,
                                                width: 130,
                                                child: Text(
                                                  '${provider.solutionRem}',
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 40,
                                                  width: 70,
                                                  child: Text(
                                                    'ml.',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: AppColor.textDark1,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (openTemp == false) {
                                        provider.openHeater();
                                        setState(() {
                                          openTemp = !openTemp;
                                        });
                                      } else {
                                        provider.closeHeater();
                                        setState(() {
                                          openTemp = !openTemp;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      width: 250,
                                      height: 110,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white10,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Heater Temp',
                                                style: TextStyle(
                                                    color: AppColor.textDark1,
                                                    fontSize: 20),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: 50,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: openTemp == false
                                                        ? Colors.transparent
                                                        : AppColor.darkWidget
                                                            .withOpacity(.3),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColor
                                                            .darkWidget),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: Text(
                                                  openTemp == false
                                                      ? 'OFF'
                                                      : 'ON',
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.darkWidget),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 40,
                                                  width: 120,
                                                  child: Text(
                                                    '${provider.heaterTemp.toStringAsFixed(1)}',
                                                    style: TextStyle(
                                                        fontSize: 32,
                                                        color:
                                                            AppColor.darkWidget,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: 40,
                                                    width: 70,
                                                    child: Text(
                                                      'C ํ',
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        color:
                                                            AppColor.textDark1,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: 250,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white10,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Heater Weight',
                                          style: TextStyle(
                                              color: AppColor.textDark1,
                                              fontSize: 20),
                                        ),
                                        Container(
                                          // color: Colors.white12,
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                // color: Colors.white10,
                                                alignment:
                                                    Alignment.centerRight,
                                                height: 40,
                                                width: 130,
                                                child: Text(
                                                  '${provider.upperWeight}',
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 40,
                                                  width: 70,
                                                  child: Text(
                                                    'g.',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: AppColor.textDark1,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: 250,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white10,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Disposal Solution',
                                          style: TextStyle(
                                              color: AppColor.textDark1,
                                              fontSize: 20),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                height: 40,
                                                width: 120,
                                                child: Text(
                                                  '${provider.totalDrainVol - provider.idrainVol}',
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 40,
                                                  width: 70,
                                                  child: Text(
                                                    'ml.',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: AppColor.textDark1,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: 250,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white10,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Solution Temp',
                                          style: TextStyle(
                                              color: AppColor.textDark1,
                                              fontSize: 20),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                height: 40,
                                                width: 120,
                                                child: Text(
                                                  '${provider.solutionTemp.toStringAsFixed(1)}',
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 40,
                                                  width: 70,
                                                  child: Text(
                                                    'C ํ',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: AppColor.textDark1,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: 250,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white10,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Drain Weight',
                                          style: TextStyle(
                                              color: AppColor.textDark1,
                                              fontSize: 20),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                height: 40,
                                                width: 120,
                                                child: Text(
                                                  '${provider.drainTankWeight}',
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 40,
                                                  width: 70,
                                                  child: Text(
                                                    'g.',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: AppColor.textDark1,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: 250,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white10,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Retained Profits',
                                          style: TextStyle(
                                              color: AppColor.textDark1,
                                              fontSize: 20),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                height: 40,
                                                width: 120,
                                                child: Text(
                                                  '${provider.profit}',
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 40,
                                                  width: 70,
                                                  child: Text(
                                                    'ml.',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: AppColor.textDark1,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: 250,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white10,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pressure',
                                          style: TextStyle(
                                              color: AppColor.textDark1,
                                              fontSize: 20),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                height: 40,
                                                width: 130,
                                                child: Text(
                                                  '${provider.pressure.toStringAsFixed(1)}',
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      color:
                                                          AppColor.darkWidget,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 40,
                                                  width: 70,
                                                  child: Text(
                                                    'kPa',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: AppColor.textDark1,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    width: 250,
                                    height: 110,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white10,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    // child: Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       'Pressure',
                                    //       style: TextStyle(
                                    //           color: AppColor.textDark1,
                                    //           fontSize: 20),
                                    //     ),
                                    //     Container(
                                    //       height: 40,
                                    //       child: Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.end,
                                    //         children: [
                                    //           Container(
                                    //             alignment:
                                    //                 Alignment.centerRight,
                                    //             height: 40,
                                    //             width: 130,
                                    //             child: Text(
                                    //               '${provider.pressure.toStringAsFixed(1)}',
                                    //               style: TextStyle(
                                    //                   fontSize: 32,
                                    //                   color:
                                    //                       AppColor.darkWidget,
                                    //                   fontWeight:
                                    //                       FontWeight.bold),
                                    //             ),
                                    //           ),
                                    //           Container(
                                    //               padding:
                                    //                   EdgeInsets.only(top: 10),
                                    //               alignment:
                                    //                   Alignment.centerRight,
                                    //               height: 40,
                                    //               width: 70,
                                    //               child: Text(
                                    //                 'kPa',
                                    //                 style: TextStyle(
                                    //                   fontSize: 24,
                                    //                   color: AppColor.textDark1,
                                    //                 ),
                                    //               )),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressWidget() {
    switch (context.watch<APDSystemProvider>().apdState) {
      case APDState.NONE:
        return DrainWidget();
      case APDState.STANDBY:
        return DrainWidget();
      case APDState.IDRAIN:
        return DrainWidget();
      case APDState.PRIMMING:
        return DrainWidget();
      case APDState.DRAIN:
        return DrainWidget();
      case APDState.FILL:
        return FillWidget();
      case APDState.DWELL:
        return Dwell();
      case APDState.LASTFILL:
        return FillWidget();
      case APDState.PAUSE:
        return DrainWidget();
      case APDState.COMPLETE:
        return DrainWidget();
    }
  }

  String _getTitle() {
    switch (context.watch<APDSystemProvider>().apdState) {
      case APDState.NONE:
        return 'None';
      case APDState.STANDBY:
        return 'Standby';
      case APDState.IDRAIN:
        return 'IDrain';
      case APDState.PRIMMING:
        return 'Primming';
      case APDState.DRAIN:
        return 'Drain';
      case APDState.FILL:
        return 'Fill';
      case APDState.DWELL:
        return 'Dwell';
      case APDState.LASTFILL:
        return 'Last Fill';
      case APDState.PAUSE:
        return 'Pause';
      case APDState.COMPLETE:
        return 'Complete';
    }
  }
}
