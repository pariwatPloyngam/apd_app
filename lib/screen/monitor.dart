// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:apd_app/components/clock_view.dart';
import 'package:apd_app/components/clock_widget.dart';
import 'package:apd_app/components/liquid_widget.dart';
import 'package:apd_app/components/prog_widget.dart';
import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/screen/alert.dart';
import 'package:apd_app/screen/complete_screen.dart';
import 'package:apd_app/screen/monitor_dev.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:provider/provider.dart';

int calProgress(int tvol, int dtv, APDState state) {
  int drainVol = 0;
  if (state == APDState.DRAIN) {
    drainVol == tvol - dtv;
  } else if (state == APDState.IDRAIN) {
    drainVol == tvol - 0;
  }
  print('Drain $drainVol');
  return drainVol;
}

class MonitorPage extends StatefulWidget {
  const MonitorPage({Key? key}) : super(key: key);

  @override
  _MonitorPageState createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  bool isLoading = true;
  bool tempIsOn = false;

  @override
  void initState() {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        if (provider.apdState == APDState.COMPLETE) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CompleteScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);

    // final drainVol =
    //     calProgress(provider.tvol, provider.totalDrainVol, provider.apdState);
    return Scaffold(
        body: provider.apdState == APDState.COMPLETE
            ? CompleteScreen()
            : Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            stops: [
                          0.0,
                          1.0
                        ],
                            colors: [
                          AppColor.darkPrimary,
                          AppColor.darkSecondary
                        ])),
                    child: isLoading == true
                        ? Center(
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  strokeWidth: 10,
                                  color: AppColor.darkWidget,
                                )),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      shape: BoxShape.rectangle,
                                      color: Colors.white.withOpacity(.05),
                                      border: Border.all(
                                          width: 0.2,
                                          color: Colors.white.withOpacity(0.2)),
                                    ),
                                    width: 200,
                                    height: MediaQuery.of(context).size.height,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: provider
                                                                  .apdState ==
                                                              APDState.IDRAIN
                                                          ? AppColor.darkWidget
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  width: 200,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                        overlayColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .transparent)),
                                                    child: Text(
                                                      'I-DRAIN',
                                                      style: TextStyle(
                                                        color: provider
                                                                    .apdState ==
                                                                APDState.IDRAIN
                                                            ? AppColor
                                                                .darkPrimary
                                                            : AppColor
                                                                .textDark1,
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      // context
                                                      //         .read<
                                                      //             APDSystemProvider>()
                                                      //         .apdState =
                                                      //     APDState.IDRAIN;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      // color: Colors.white10,
                                                      border: Border.all(
                                                          color:
                                                              Colors.white12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: provider
                                                                        .apdState ==
                                                                    APDState
                                                                        .FILL
                                                                ? AppColor
                                                                    .darkWidget
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                        width: 200,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            6,
                                                        child: TextButton(
                                                          style: ButtonStyle(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .transparent)),
                                                          child: Text(
                                                            'FILL',
                                                            style: TextStyle(
                                                              color: provider
                                                                          .apdState ==
                                                                      APDState
                                                                          .FILL
                                                                  ? AppColor
                                                                      .darkPrimary
                                                                  : AppColor
                                                                      .textDark1,
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            // context
                                                            //         .read<
                                                            //             APDSystemProvider>()
                                                            //         .apdState =
                                                            //     APDState.FILL;
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: provider
                                                                        .apdState ==
                                                                    APDState
                                                                        .DWELL
                                                                ? AppColor
                                                                    .darkWidget
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                        width: 200,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            6,
                                                        child: TextButton(
                                                          style: ButtonStyle(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .transparent)),
                                                          child: Text(
                                                            'DWELL',
                                                            style: TextStyle(
                                                              color: provider
                                                                          .apdState ==
                                                                      APDState
                                                                          .DWELL
                                                                  ? AppColor
                                                                      .darkPrimary
                                                                  : AppColor
                                                                      .textDark1,
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            // context
                                                            //         .read<
                                                            //             APDSystemProvider>()
                                                            //         .apdState =
                                                            //     APDState.DWELL;
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: provider
                                                                        .apdState ==
                                                                    APDState
                                                                        .DRAIN
                                                                ? AppColor
                                                                    .darkWidget
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                        width: 200,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            6,
                                                        child: TextButton(
                                                          style: ButtonStyle(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .transparent)),
                                                          child: Text(
                                                            'DRAIN',
                                                            style: TextStyle(
                                                              color: provider
                                                                          .apdState ==
                                                                      APDState
                                                                          .DRAIN
                                                                  ? AppColor
                                                                      .darkPrimary
                                                                  : AppColor
                                                                      .textDark1,
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            // context
                                                            //         .read<
                                                            //             APDSystemProvider>()
                                                            //         .apdState =
                                                            //     APDState.DRAIN;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: provider
                                                                  .apdState ==
                                                              APDState.LASTFILL
                                                          ? AppColor.darkWidget
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  width: 200,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6,
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                        overlayColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .transparent)),
                                                    child: Text(
                                                      'LAST FILL',
                                                      style: TextStyle(
                                                        color: provider
                                                                    .apdState ==
                                                                APDState
                                                                    .LASTFILL
                                                            ? AppColor
                                                                .darkPrimary
                                                            : AppColor
                                                                .textDark1,
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      // context
                                                      //         .read<
                                                      //             APDSystemProvider>()
                                                      //         .apdState =
                                                      //     APDState.LASTFILL;
                                                    },
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(),
                                      Container(
                                        child: buildProgressWidget(),
                                      ),
                                      Container(
                                        width: 450,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                'เวลาทั้งหมด',
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color: AppColor.textDark1),
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              child: OverallTime(),
                                            )
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   width: 510,
                                      //   height: 100,

                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       SizedBox(),
                                      //       Container(
                                      //         width: 100,
                                      //         height: 100,
                                      //         decoration: BoxDecoration(
                                      //             color: tempIsOn == true
                                      //                 ? AppColor.darkWidget
                                      //                 : Colors.transparent,
                                      //             border: Border.all(
                                      //                 width: 0.5,
                                      //                 color: Colors.white12),
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     16)),
                                      //         child: IconButton(
                                      //           icon: Icon(
                                      //             Icons.local_fire_department,
                                      //             size: 70,
                                      //             color: tempIsOn == true
                                      //                 ? Colors.white10
                                      //                 : AppColor.darkWidget,
                                      //           ),
                                      //           onPressed: () {
                                      //             setState(() {
                                      //               tempIsOn != tempIsOn;
                                      //             });
                                      //           },
                                      //         ),
                                      //       )
                                      //     ],
                                      //   ),
                                      // )
                                      // TempControl()
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 500,
                                  margin: EdgeInsets.all(16),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.05),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        width: 0.2,
                                        color: Colors.white.withOpacity(0.2)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'รอบที่',
                                                    style: TextStyle(
                                                        fontSize: 36,
                                                        color:
                                                            AppColor.textDark1),
                                                  ),
                                                  Text(
                                                    '${provider.currentCycle} / ${provider.totalCycle}',
                                                    style: TextStyle(
                                                        fontSize: 36,
                                                        color:
                                                            AppColor.darkWidget,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                                onLongPress: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MonitorDevPage()),
                                                  );
                                                },
                                                child:
                                                    ClockWidgetHorizontalStyle())
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 240,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white.withOpacity(.03),
                                          border:
                                              Border.all(color: Colors.white12),
                                        ),
                                        child: buildProgressIndicator(),
                                      ),
                                      Container(
                                        height: 240,
                                        width: 470,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                                color: Colors.white12),
                                            color:
                                                Colors.white.withOpacity(.03)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      width: 180,
                                                      height: 50,
                                                      child: Text(
                                                        'น้ำยาคงเหลือ',
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: AppColor
                                                              .textDark1,
                                                        ),
                                                      )),
                                                  Container(
                                                      width: 150,
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          '${provider.solutionRem}',
                                                          style: TextStyle(
                                                            fontSize: 32,
                                                            color: AppColor
                                                                .darkWidget,
                                                          ),
                                                        ),
                                                      )),
                                                  Container(
                                                    width: 70,
                                                    height: 50,
                                                    child: Text(
                                                      'มล.',
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        color:
                                                            AppColor.textDark1,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      width: 180,
                                                      height: 40,
                                                      child: Text(
                                                        'น้ำยาทิ้ง',
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: AppColor
                                                              .textDark1,
                                                        ),
                                                      )),
                                                  Container(
                                                      width: 150,
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          '${provider.totalDrainVol}',
                                                          style: TextStyle(
                                                            fontSize: 32,
                                                            color: AppColor
                                                                .darkWidget,
                                                          ),
                                                        ),
                                                      )),
                                                  Container(
                                                    width: 70,
                                                    height: 50,
                                                    child: Text(
                                                      'มล.',
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        color:
                                                            AppColor.textDark1,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      width: 180,
                                                      height: 50,
                                                      child: Text(
                                                        'กำไรทั้งหมด',
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: AppColor
                                                              .textDark1,
                                                        ),
                                                      )),
                                                  Container(
                                                      width: 150,
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          '${provider.profit}',
                                                          style: TextStyle(
                                                            fontSize: 32,
                                                            color: AppColor
                                                                .darkWidget,
                                                          ),
                                                        ),
                                                      )),
                                                  Container(
                                                    width: 70,
                                                    height: 50,
                                                    child: Text(
                                                      'มล.',
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        color:
                                                            AppColor.textDark1,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          // child: Column(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.spaceEvenly,
                                          //     children: [
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.start,
                                          //         children: [
                                          //           Column(
                                          //             children: [
                                          //               Text(
                                          //                 'น้ำยาคงเหลือ',
                                          //                 style: TextStyle(
                                          //                     fontSize: 30,
                                          //                     color: AppColor
                                          //                         .textDark1),
                                          //               ),
                                          //               Text(
                                          //                 '${provider.solutionRem} มล.',
                                          //                 style: TextStyle(
                                          //                     fontSize: 36,
                                          //                     color: AppColor
                                          //                         .darkWidget,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold),
                                          //               )
                                          //             ],
                                          //           ),
                                          //           Padding(
                                          //             padding:
                                          //                 const EdgeInsets.only(
                                          //                     right: 30,
                                          //                     left: 50),
                                          //             child: SizedBox(
                                          //               height: 100,
                                          //               width: 1,
                                          //               child: Container(
                                          //                   color: AppColor
                                          //                       .textDark1),
                                          //             ),
                                          //           ),
                                          //           Column(
                                          //             children: [
                                          //               Text(
                                          //                 'น้ำยาทิ้ง',
                                          //                 style: TextStyle(
                                          //                     fontSize: 30,
                                          //                     color: AppColor
                                          //                         .textDark1),
                                          //               ),
                                          //               Text(
                                          //                 '${provider.totalDrainVol}' +
                                          //                     ' มล.',
                                          //                 style: TextStyle(
                                          //                     fontSize: 36,
                                          //                     color: AppColor
                                          //                         .darkWidget,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold),
                                          //               )
                                          //             ],
                                          //           )
                                          //         ],
                                          //       ),

                                          //       Row(
                                          //         children: [
                                          //           Text(
                                          //             'กำไรทั้งหมด (Total UF)',
                                          //             style: TextStyle(
                                          //                 fontSize: 30,
                                          //                 color: AppColor
                                          //                     .textDark1),
                                          //           ),
                                          //           SizedBox(
                                          //             width: 10,
                                          //           ),
                                          //           Text(
                                          //             provider.profit < 0
                                          //                 ? '0'
                                          //                 : '${provider.profit}',
                                          //             style: TextStyle(
                                          //                 fontSize: 36,
                                          //                 color: AppColor
                                          //                     .darkWidget,
                                          //                 fontWeight:
                                          //                     FontWeight.bold),
                                          //           ),
                                          //           SizedBox(
                                          //             width: 10,
                                          //           ),
                                          //           Text(
                                          //             'มล.',
                                          //             style: TextStyle(
                                          //                 fontSize: 30,
                                          //                 color: AppColor
                                          //                     .textDark1),
                                          //           )
                                          //         ],
                                          //       )
                                          //     ]),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'อุ่นน้ำยา',
                                              style: TextStyle(
                                                  color: AppColor.darkWidget,
                                                  fontSize: 30),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            FlutterSwitch(
                                              width: 100.0,
                                              height: 45.0,
                                              valueFontSize: 25.0,
                                              toggleSize: 37.0,
                                              value: provider.heater,
                                              borderRadius: 30.0,
                                              padding: 5.0,
                                              showOnOff: true,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              activeToggleColor:
                                                  AppColor.darkPrimary,
                                              activeTextColor:
                                                  AppColor.darkPrimary,
                                              inactiveToggleColor:
                                                  AppColor.textDark1,
                                              inactiveTextColor:
                                                  AppColor.textDark1,
                                              activeText: "เปิด",
                                              inactiveText: "ปิด",
                                              activeColor: AppColor.darkWidget
                                                  .withBlue(200),
                                              inactiveColor: Colors.white24,
                                              onToggle: (val) {
                                                provider.heater = val;
                                                if (provider.heater == true) {
                                                  provider.openHeater();
                                                } else {
                                                  provider.closeHeater();
                                                }
                                                // setState(() {
                                                //   tempIsOn = val;
                                                //   print(tempIsOn);
                                                // });
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                  context.watch<APDSystemProvider>().alertState ==
                          AlertState.NONE
                      ? SizedBox()
                      : AlertWidget()
                  // context.watch<APDSystemProvider>().isError == false && AlertState == AlertState.NONE
                  //     ? AlertWidget()
                  //     : SizedBox()
                ],
              ));
  }

  String _getTitle() {
    switch (context.watch<APDSystemProvider>().apdState) {
      case APDState.NONE:
        return 'NONE';
      case APDState.STANDBY:
        return 'STANDBY';
      case APDState.IDRAIN:
        return 'I-DRAIN';
      case APDState.PRIMMING:
        return 'PRIMMING';
      case APDState.DRAIN:
        return 'DRAIN';
      case APDState.FILL:
        return 'FILL';
      case APDState.DWELL:
        return 'DWELL';
      case APDState.LASTFILL:
        return 'LAST FILL';
      case APDState.PAUSE:
        return 'PAUSE';
      case APDState.COMPLETE:
        return 'COMPLETE';
    }
  }

  Widget buildProgressWidget() {
    switch (context.watch<APDSystemProvider>().apdState) {
      case APDState.NONE:
        return DrainProgress();
      case APDState.STANDBY:
        return DrainProgress();
      case APDState.IDRAIN:
        return DrainProgress();
      case APDState.PRIMMING:
        return DrainProgress();
      case APDState.DRAIN:
        return DrainProgress();
      case APDState.FILL:
        return FillProgress();
      case APDState.DWELL:
        return DwellProgress();
      case APDState.LASTFILL:
        return FillProgress();
      case APDState.PAUSE:
        return DrainProgress();
      case APDState.COMPLETE:
        return SizedBox();
    }
  }

  Widget buildProgressIndicator() {
    switch (context.watch<APDSystemProvider>().apdState) {
      case APDState.NONE:
        return DrainIndicator();
      case APDState.STANDBY:
        return DrainIndicator();
      case APDState.IDRAIN:
        return DrainIndicator();
      case APDState.PRIMMING:
        return DrainIndicator();
      case APDState.DRAIN:
        return DrainIndicator();
      case APDState.FILL:
        return FillIndicator();
      case APDState.DWELL:
        return DwellIndicator();
      case APDState.LASTFILL:
        return FillIndicator();
      case APDState.PAUSE:
        return DrainIndicator();
      case APDState.COMPLETE:
        return SizedBox();
    }
  }
}

class TempControl extends StatelessWidget {
  const TempControl({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 40),
      width: 510,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          border: Border.all(width: 0.5, color: Colors.white12),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'อุณหภูมิ',
                style: TextStyle(
                  color: AppColor.textDark1,
                  fontSize: 36,
                ),
              ),
              FlutterSwitch(
                width: 80.0,
                height: 35.0,
                valueFontSize: 15.0,
                toggleSize: 30.0,
                value: provider.heater,
                borderRadius: 30.0,
                padding: 3.0,
                showOnOff: true,
                duration: Duration(milliseconds: 500),
                activeToggleColor: AppColor.darkPrimary,
                activeTextColor: AppColor.darkPrimary,
                inactiveToggleColor: AppColor.textDark1,
                inactiveTextColor: AppColor.textDark1,
                activeText: "เปิด",
                inactiveText: "ปิด",
                activeColor: AppColor.darkWidget.withBlue(200),
                inactiveColor: Colors.white24,
                onToggle: (val) {
                  provider.heater = val;
                  if (provider.heater == true) {
                    provider.openHeater();
                  } else {
                    provider.closeHeater();
                  }
                  // setState(() {
                  //   tempIsOn = val;
                  //   print(tempIsOn);
                  // });
                },
              ),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         fixedSize: Size(50, 15)),
              //     onPressed: () {
              //       provider.openHeater();
              //     },
              //     child: Text('')),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         fixedSize: Size(50, 15)),
              //     onPressed: () {
              //       provider.closeHeater();
              //     },
              //     child: Text(''))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    'ฮีตเตอร์',
                    style: TextStyle(
                      color: AppColor.textDark1,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    (provider.heaterTemp).toStringAsFixed(2),
                    style: TextStyle(
                        color: AppColor.darkWidget,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // SizedBox(
              //   width: 150,
              // ),
              Row(
                children: [
                  Text(
                    'น้ำยา',
                    style: TextStyle(
                      color: AppColor.textDark1,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    (provider.solutionTemp).toStringAsFixed(2),
                    style: TextStyle(
                        color: AppColor.darkWidget,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment:
          //       MainAxisAlignment.end,
          //   children: [
          //     Text(
          //       'Heater Temp ${(provider.heaterTemp).toStringAsFixed(2)}',
          //       style: TextStyle(
          //           color: AppColor.textDark1,
          //           fontSize: 22),
          //     ),
          //     SizedBox(height: 10,),
          //     Text(
          //       'Solution Temp ${(provider.solutionTemp).toStringAsFixed(2)}',
          //       style: TextStyle(
          //           color: AppColor.textDark1,
          //           fontSize: 22),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
