// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/provider/dummy_profile.dart';
import 'package:apd_app/screen/control.dart';
import 'package:apd_app/screen/user_guide.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double textsize = 24;
  bool toggle = true;

  final player = AudioPlayer();
  bool lessHour = false;

  Map<String, int> calculateTime(int timer) {
    Duration duration = Duration(seconds: timer);
    String formattedTime;

    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    if (hours > 0) {
      formattedTime =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    } else {
      formattedTime = '${minutes.toString().padLeft(2, '0')}';
    }

    // if (hours < 0) {
    //   setState(() {
    //     lessHour = true;
    //   });
    // } else {
    //   setState(() {
    //     lessHour = false;
    //   });
    // }
    return {'minutes': minutes, 'hours': hours};
  }

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<APDSystemProvider>().apdState = APDState.NONE;
  // }

  Future _popupSound() async {
    String path = 'assets/sounds/popup.mp3';
    await player.setAsset(path);
    await player.play();
  }


  @override
  Widget build(BuildContext context) {
    final state = Provider.of<APDSystemProvider>(context).connectionState;
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
        child: state == SerialConnectionState.CONNECTED
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onLongPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ControlPage()),
                        );
                      },
                      child: Text(
                        'APD Program',
                        style: TextStyle(
                            fontSize: 40,
                            color: AppColor.textDark1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: width,
                    height: 500,
                    // color: Colors.white10,
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: dummyProfiles.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> profile = dummyProfiles[index];
                          Map<String, int> times =
                              calculateTime(profile['time']);
                          return Card(
                            color: Colors.white12,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            margin: EdgeInsets.all(14.0),
                            child: Container(
                              width: 400,
                              // color: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'โปรแกรม ${profile['profileName']}',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: AppColor.darkWidget,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            profile['lastFillVol'] == 0
                                                ? 'No Last Fill'
                                                : 'Last Fill',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color:
                                                    profile['lastFillVol'] == 0
                                                        ? Colors.white12
                                                        : AppColor.darkWidget))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: 30,
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          height: 30,
                                          // color: Colors.amber,
                                          child: Text(
                                            'ปริมาณน้ำยาที่ใช้',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: 100,
                                          height: 30,
                                          // color: Colors.red,
                                          child: Text(
                                            '${profile['totalVol']}',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 60,
                                          height: 30,
                                          // color: Colors.black,
                                          child: Text(
                                            'มล.',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: 30,
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          height: 30,
                                          // color: Colors.amber,
                                          child: Text(
                                            'ปริมาณน้ำยาที่เติม',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: 100,
                                          height: 30,
                                          // color: Colors.red,
                                          child: Text(
                                            '${profile['fillVol']}',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 60,
                                          height: 30,
                                          // color: Colors.black,
                                          child: Text(
                                            'มล.',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: 30,
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          height: 30,
                                          // color: Colors.amber,
                                          child: Text(
                                            'เติมขั้นต่ำ',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: 100,
                                          height: 30,
                                          // color: Colors.red,
                                          child: Text(
                                            '${profile['fillMin']}',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 60,
                                          height: 30,
                                          // color: Colors.black,
                                          child: Text(
                                            '% ',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: 30,
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          height: 30,
                                          // color: Colors.amber,
                                          child: Text(
                                            'ปริมาณที่เอาออก',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: 100,
                                          height: 30,
                                          // color: Colors.red,
                                          child: Text(
                                            '${profile['idrainVol']}',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 60,
                                          height: 30,
                                          // color: Colors.black,
                                          child: Text(
                                            'มล.',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: 30,
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          height: 30,
                                          // color: Colors.amber,
                                          child: Text(
                                            'เอาออกขั้นต่ำ',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: 100,
                                          height: 30,
                                          // color: Colors.red,
                                          child: Text(
                                            '${profile['drainMin']}',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 60,
                                          height: 30,
                                          // color: Colors.black,
                                          child: Text(
                                            '% ',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: 30,
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 30,
                                          // color: Colors.amber,
                                          child: Text(
                                            'เวลาที่ใช้',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 40,
                                          height: 30,
                                          // color: Colors.blue,
                                          child: Text(
                                            '${times['hours']}',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 80,
                                          height: 30,
                                          // color: Colors.red,
                                          child: Text(
                                            'ชั่วโมง',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 40,
                                          height: 30,
                                          // color: Colors.amber,
                                          child: Text(
                                            '${times['minutes']}',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 50,
                                          height: 30,
                                          // color: Colors.black,
                                          child: Text(
                                            'นาที',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    height: 30,
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 190,
                                          height: 30,
                                          // color: Colors.amber,
                                          child: Text(
                                            profile['lastFillVol'] > 0
                                                ? 'ICO'
                                                : '',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 10),
                                          width: 160,
                                          height: 30,
                                          // color: Colors.red,
                                          child: Text(
                                            profile['lastFillVol'] > 0
                                                ? profile['ico'] == 0
                                                    ? 'น้ำยาปกติ'
                                                    : 'น้ำยาพิเศษ'
                                                : '',
                                            style: TextStyle(
                                                fontSize: textsize,
                                                color: AppColor.textDark1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            fixedSize: Size(500, 60)),
                                        onPressed: () {
                                          provider.alertState = AlertState.NONE;
                                          if (provider.drainTankWeight > 3000) {
                                            _showAlertDialog(context);
                                            _popupSound();
                                          } else {
                                            provider.setProfile(profile);

                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserGuide()
                                                  // SystemInitPage(),
                                                  // MonitorPage()
                                                  ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          'เลือก',
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                              // child: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Text('โปรแกรม ${profile['profileName']}',
                              //             style: TextStyle(
                              //                 fontSize: 30,
                              //                 color: AppColor.darkWidget,
                              //                 fontWeight: FontWeight.bold)),
                              //         Text(
                              //             profile['lastFillVol'] == 0
                              //                 ? 'No Last Fill'
                              //                 : 'Last Fill',
                              //             style: TextStyle(
                              //                 fontSize: 24,
                              //                 color: profile['lastFillVol'] == 0
                              //                     ? Colors.white12
                              //                     : AppColor.darkWidget))
                              //       ],
                              //     ),
                              //     // SizedBox(
                              //     //   height: 20,
                              //     // ),
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               'ปริมาณน้ำยาที่ใช้',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               'ปริมาณน้ำยาที่เติม',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               'เติมขั้นต่ำ',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               'ปริมาณที่เอาออก',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               'เอาออกขั้นต่ำ',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               'เวลาที่ใช้',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               profile['lastFillVol'] > 0
                              //                   ? 'ICO'
                              //                   : '',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //           ],
                              //         ),
                              //         Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               '${profile['totalVol']}',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               '${profile['fillVol']}',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               '${profile['fillMin']}',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               '${profile['idrainVol']}',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               '${profile['drainMin']}',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               times,
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               profile['lastFillVol'] > 0
                              //                   ? profile['ico'] == 0
                              //                       ? 'น้ำยาปกติ'
                              //                       : 'น้ำยาพิเศษ'
                              //                   : '',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //           ],
                              //         ),
                              //         Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.end,
                              //           children: [
                              //             Text(
                              //               'มล.',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               'มล.',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               '%',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               'มล.',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               '%',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               'ชม.',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //             Text(
                              //               '',
                              //               style: TextStyle(
                              //                   fontSize: textsize,
                              //                   color: AppColor.textDark1),
                              //             ),
                              //           ],
                              //         ),
                              //       ],
                              //     ),
                              //     Center(
                              //       child: ElevatedButton(
                              //           style: ElevatedButton.styleFrom(
                              //               shape: RoundedRectangleBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(12)),
                              //               fixedSize: Size(500, 60)),
                              //           onPressed: () {
                              //             provider.alertState = AlertState.NONE;
                              //             if (provider.drainTankWeight > 1500) {
                              //               _showAlertDialog(context);
                              //               _popupSound();
                              //             } else {
                              //               provider.setProfile(profile);

                              //               Navigator.of(context).push(
                              //                 MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         UserGuide()
                              //                     // SystemInitPage(),
                              //                     // MonitorPage()
                              //                     ),
                              //               );
                              //             }
                              //           },
                              //           child: Text(
                              //             'เลือก',
                              //             style: TextStyle(
                              //               fontSize: 25,
                              //             ),
                              //           )),
                              //     )
                              //   ],
                              // ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            : state == SerialConnectionState.CONNECTING
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              strokeWidth: 15,
                              color: AppColor.darkWidget,
                            )),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          'กำลังเชื่อมต่ออุปกรณ์...',
                          style: TextStyle(
                              fontSize: 38, color: AppColor.textDark1),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        size: 250,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'การเชื่อมต่ออุปกรณ์มีปัญหา',
                            style: TextStyle(
                                fontSize: 38, color: AppColor.textDark1),
                          ),
                          Text(
                            'กรุณาหยุดการใช้งาน และติดต่อเจ้าหน้าที่',
                            style: TextStyle(
                                fontSize: 38, color: AppColor.textDark1),
                          ),
                        ],
                      )
                    ],
                  )),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // actionsPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 80, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          backgroundColor: AppColor.darkPrimary,
          title: Text(
            'แจ้งเตือน',
            style: TextStyle(
              fontSize: 38,
              color: AppColor.darkWidget,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: 550,
            child: Text(
              'ปริมาณของเสียในทั้งน้ำทิ้งมีปริมาณมากเกินไป อาจทำให้เกิดอันตรายได้ กรุณานำขอเสียในถังไปทิ้งก่อน',
              // textAlign: TextAlign.justify,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 30, color: AppColor.textDark1),
            ),
          ),
          // Container(
          //   width: 500,
          //   height: 150,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // Text(
          //       //   'แจ้งเตือน',
          //       //   style: TextStyle(
          //       //       fontSize: 30,
          //       //       color: AppColor.darkWidget,
          //       //       fontWeight: FontWeight.bold,
          //       //       decoration: TextDecoration.underline),
          //       // ),
          //       // SizedBox(
          //       //   height: 20,
          //       // ),
          //       Text(
          //         '_xbf',
          //         textAlign: TextAlign.justify,
          //         style: TextStyle(fontSize: 24, color: AppColor.textDark1),
          //       )
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            SizedBox(
              width: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: TextButton(
                child: Text(
                  'ตกลง',
                  style: TextStyle(
                    fontSize: 32,
                    color: AppColor.darkWidget,
                  ),
                ),
                onPressed: () {
                  // player.dispose();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
