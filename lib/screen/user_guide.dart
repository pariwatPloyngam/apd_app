// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:async';

import 'package:apd_app/components/primming_progress.dart';
import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/screen/alert.dart';
import 'package:apd_app/screen/home_screen.dart';
import 'package:apd_app/screen/monitor.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum userguild {
  check,
  handclean,
  setupSolution,
  insertCasset,
  insertDrainTank,
  insertDrainLine,
  insertHeaterline,
  insertIcoLine,
  insertSolutionLine,
  primming,
  connectPatientLine,
}

class UserGuide extends StatefulWidget {
  const UserGuide({super.key});

  @override
  State<UserGuide> createState() => _UserGuideState();
}

class _UserGuideState extends State<UserGuide> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // final provider = Provider.of<APDSystemProvider>(context, listen: false);
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 140, 70, 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ขั้นตอนปฏิบัติสำหรับการใช้เครื่องล้างไตทางช่องท้อง',
                      style: TextStyle(
                          color: AppColor.textDark1,
                          fontSize: 44,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ขั้นตอนปฏิบัติก่อนการใช้เครื่องล้างไตทางช่องท้องอัตโนมัติ เป็นสิ่งสำคัญในการแสดงวิธีการใช้งานอย่างถูกต้อง กรุณาปฏิบัติตามขั้นตอนอย่างเคร่งครัดเพื่อความปลอดภัยของผู้ใช้ เมื่อทำตามข้อปฏิบัติเรียบร้อยแล้วให้กดปุ่ม "ถัดไป" บนหน้าจอ',
                      style: TextStyle(color: AppColor.textDark1, fontSize: 28),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(200, 80)),
                            onPressed: () {
                              context.read<APDSystemProvider>().alertState =
                                  AlertState.NONE;
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Guide()),
                              );
                              // provider.closeAllValve();
                              //   Navigator.push(
                              //     context,
                              //     PageRouteBuilder(
                              //       transitionDuration:
                              //           Duration(milliseconds: 700),
                              //       pageBuilder: (context, animation,
                              //               secondaryAnimation) =>
                              //           HandClean(),
                              //       transitionsBuilder: (context, animation,
                              //           secondaryAnimation, child) {
                              //         const begin = Offset(1.0, 0.0);
                              //         const end = Offset.zero;
                              //         const curve = Curves.ease;
                              //         var tween = Tween(begin: begin, end: end)
                              //             .chain(CurveTween(curve: curve));
                              //         var offsetAnimation =
                              //             animation.drive(tween);
                              //         return SlideTransition(
                              //             position: offsetAnimation,
                              //             child: child);
                              //       },
                              //     ),
                              //   );
                            },
                            child: Text(
                              'ถัดไป',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w400),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              context.watch<APDSystemProvider>().alertState != AlertState.NONE
                  ? AlertWidget()
                  : SizedBox()
            ],
          )),
    );
  }
}

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  userguild state = userguild.check;
  bool onPrimming = false;
  void handleUserGuild() {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    setState(() {
      if (state == userguild.check) {
        state = userguild.handclean;
      } else if (state == userguild.handclean) {
        state = userguild.setupSolution;
      } else if (state == userguild.setupSolution) {
        state = userguild.insertCasset;
      } else if (state == userguild.insertCasset) {
        provider.closeAllValve();
        state = userguild.insertDrainTank;
      } else if (state == userguild.insertDrainTank) {
        state = userguild.insertDrainLine;
      } else if (state == userguild.insertDrainLine) {
        state = userguild.insertHeaterline;
      } else if (state == userguild.insertHeaterline) {
        // print(provider.profile);
        state = userguild.insertIcoLine;
      } else if (state == userguild.insertIcoLine) {
        state = userguild.insertSolutionLine;
      } else if (state == userguild.insertSolutionLine) {
        provider.onprimming = true;
        provider.startApdWithProfile();
        state = userguild.connectPatientLine;
      } else if (state == userguild.primming) {
      } else if (state == userguild.connectPatientLine) {
        provider.confirmStart();
        provider.alertState = AlertState.NONE;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MonitorPage()),
        );
      }
      print(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // final provider = Provider.of<APDSystemProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: width,
        height: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
        child: context.watch<APDSystemProvider>().onprimming == false
            ? Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white10,
                        border:
                            Border.all(width: 2, color: AppColor.darkWidget),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(_buildAnimateAsset()))),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                          // color: AppColor.darkHeader.withOpacity(.4)
                          ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.only(bottom: 30),
                                alignment: Alignment.bottomLeft,
                                width: 900,
                                height: 400,
                                // color: Colors.amber,
                                child: Text(
                                  _buildText(),
                                  style: TextStyle(
                                      backgroundColor:
                                          Color.fromARGB(197, 0, 0, 0),
                                      fontSize: 33,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(200, 80)),
                                      onPressed: () {
                                        handleUserGuild();
                                      },
                                      child: Text(_buildBtnText(),
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400))),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            // Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         height: 100,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           ClipRRect(
            //             borderRadius: BorderRadius.circular(16),
            //             child: Container(
            //               width: 650,
            //               height: 450,
            //               decoration: BoxDecoration(
            //                 color: Colors.white10,
            //                 borderRadius: BorderRadius.circular(16),
            //                 // image: DecorationImage(
            //                 //     fit: BoxFit.cover,
            //                 //     image: AssetImage(_buildAnimateAsset()))
            //               ),
            //               child: Image.asset(
            //                 _buildAnimateAsset(),
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //           Container(
            //             padding: EdgeInsets.symmetric(vertical: 10),
            //             width: 450,
            //             height: 450,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 // Text(
            //                 //   'Step 1',
            //                 //   style: TextStyle(
            //                 //       fontSize: 34, color: AppColor.textDark1),
            //                 // ),
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 Text(
            //                   _buildText(),
            //                   textAlign: TextAlign.start,
            //                   style: TextStyle(
            //                       fontSize: 28,
            //                       color: AppColor.textDark1,
            //                       overflow: TextOverflow.clip),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       Container(
            //         height: 150,
            //         padding: EdgeInsets.symmetric(horizontal: 80),
            //         child: Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               SizedBox(),
            //               ElevatedButton(
            //                   style: ElevatedButton.styleFrom(
            //                       fixedSize: Size(200, 80)),
            //                   onPressed: () {
            //                     handleUserGuild();
            //                   },
            //                   child: Text(
            //                     _buildBtnText(),
            //                     style: TextStyle(
            //                         fontSize: 24, fontWeight: FontWeight.w400),
            //                   ))
            //             ]),
            //       )
            //     ],
            //   )
            : PrimmingIndicator(),
      ),
    );
  }

  String _buildBtnText() {
    switch (state) {
      case userguild.connectPatientLine:
        return 'เริ่ม';
      case userguild.insertSolutionLine:
        return 'เริ่ม Primming';
      default:
    }
    return 'ถัดไป';
  }

  String _buildAnimateAsset() {
    switch (state) {
      case userguild.check:
        return 'assets/image/demo.gif';
      case userguild.handclean:
        return 'assets/image/demo.gif';
      case userguild.setupSolution:
        return 'assets/image/demo.gif';
      case userguild.insertCasset:
        return 'assets/image/demo.gif';
      case userguild.insertDrainTank:
        return 'assets/image/demo.gif';
      case userguild.insertDrainLine:
        return 'assets/image/demo.gif';
      case userguild.insertHeaterline:
        return 'assets/image/demo.gif';
      case userguild.insertIcoLine:
        return 'assets/image/demo.gif';
      case userguild.insertSolutionLine:
        return 'assets/image/demo.gif';
      case userguild.primming:
        return 'assets/image/demo.gif';
      case userguild.connectPatientLine:
        return 'assets/image/demo.gif';
    }
  }

  String _buildText() {
    switch (state) {
      case userguild.check:
        return 'ตรวจสอบว่ามีสิ่งของอยู่ในช่องใส่ Cassette หรือไม่';
      case userguild.handclean:
        return 'ล้างมือให้สะอาดด้วยสบู่ ตามตัวอย่าง';
      case userguild.setupSolution:
        return 'แขวนถุงน้ำยาบนที่แขวน';
      case userguild.insertCasset:
        return 'ติดตั้ง Cassette กับตัวเครื่องและดันให้เข้าที่ หลังจากนั้นให้นำ Connector ของสาย Patient ไปแขวนไว้ยังตำแหน่งตามตัวอย่าง';
      case userguild.insertDrainTank:
        return 'ติดตั้งถังน้ำยาทิ้งไว้ในตำแหน่งที่กำหนด โดยหันด้านที่มี Connector ออกมาทางหน้าเครื่อง แล้วต่อสายลมเข้ากับถัง';
      case userguild.insertDrainLine:
        return 'ดึงฝาปิดของสายน้ำยาทิ้งออก (สายที่3) แล้วต่อเข้ากับถัง';
      case userguild.insertHeaterline:
        return 'ดึงฝาปิดของสายน้ำยาเข้า (สายที่2) แล้วต่อเข้ากับถุงน้ำยาบนแท่นให้ความร้อน';
      case userguild.insertIcoLine:
        return 'ดึงฝาปิดของสายน้ำยาพิเศษ (สายที่1) แล้วต่อเข้ากับถุงน้ำยาพิเศษ';
      case userguild.insertSolutionLine:
        return 'ติดตั้งถุงน้ำยาทั้งหมดเข้ากับ Cassette ช่องไหนไม่ได้ใช้ ใช้ฝาปิดให้แน่น หลังจากน้ั้นทำการหักขั้วสายน้ำยาบริเวณขั้วสีเขียว กดปุ่ม "Primming" เพื่อทำการไล่อากาศภายในระบบ';
      case userguild.primming:
        return 'ไล่ฟองอากาศ';
      case userguild.connectPatientLine:
        return 'นำสาย Patient มาต่อกับ Connector ที่ช่องท้อง แล้วกด "เริ่ม" เพื่อเริ่มทำการล้างไต ใหากนขณะล้างไตมีปัญหาใหปฏิบัติตามคำแนะนำเบื่องต้นที่ระบบเเจ้ง';
    }
  }
}

enum userguild2 { releasePatientLine, releasedrainLine, complete }

class Guide2 extends StatefulWidget {
  const Guide2({super.key});

  @override
  State<Guide2> createState() => _Guide2State();
}

class _Guide2State extends State<Guide2> {
  userguild2 state = userguild2.releasePatientLine;
  bool onPrimming = false;
  bool releaseSolution = true;

  void handleUserGuild() {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    setState(() {
      if (state == userguild2.releasePatientLine) {
        provider.allValveHome();
        state = userguild2.releasedrainLine;
        releaseSolution = false;

        // // Simulate a change in data after 15 seconds
        // Timer(Duration(seconds: 15), () {
        //   data = "updated data";
        //   print("Data updated!");
        // });
        Future.delayed(const Duration(seconds: 30), () {
          releaseSolution = true;
          setState(() {});
        });
        // provider.allValveHome();
        // var data = provider.drainTankWeight;

        // Set up a timer to check the data every 30 seconds
        // Timer.periodic(Duration(seconds: 30), (timer) {
        //   // Check if the data has changed
        //   if (isDataUnchanged(data)) {
        //     setState(() {
        //       releaseSolution = true;
        //     });
        //     state = userguild2.releasedrainLine;
        //     print("Data has not changed for 30 seconds.");
        //   } else {
        //     print("Data has changed.");
        //     setState(() {
        //       releaseSolution = false;
        //     });
        //     // Update the data variable if needed
        //     data = provider.drainTankWeight;
        //   }
        // });
      } else if (state == userguild2.releasedrainLine) {
        // provider.closeAllValve();

        state = userguild2.complete;
      } else if (state == userguild2.complete) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
      print(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // final provider = Provider.of<APDSystemProvider>(context, listen: false);
    return Scaffold(
      body: releaseSolution == false
          ? Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      stops: [0.0, 1.0],
                      colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          color: AppColor.darkWidget,
                          strokeWidth: 15,
                        )),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'กรุณารอสักครู่',
                          style: TextStyle(
                              fontSize: 38, color: AppColor.textDark1),
                        ),
                        Text(
                          'กำลังระบายน้ำยาที่เหลือลงถังทิ้ง',
                          style: TextStyle(
                              fontSize: 38, color: AppColor.textDark1),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.all(20),
              width: width,
              height: height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      stops: [0.0, 1.0],
                      colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
              child: context.watch<APDSystemProvider>().onprimming == false
                  ? Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white10,
                              border: Border.all(
                                  width: 2, color: AppColor.darkWidget),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(_buildAnimateAsset()))),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                                // color: AppColor.darkHeader.withOpacity(.4)
                                ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(bottom: 30),
                                      alignment: Alignment.bottomLeft,
                                      width: 900,
                                      height: 400,
                                      // color: Colors.amber,
                                      child: Text(
                                        _buildText(),
                                        style: TextStyle(
                                            backgroundColor:
                                                Color.fromARGB(197, 0, 0, 0),
                                            fontSize: 33,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(200, 80)),
                                            onPressed: () {
                                              handleUserGuild();
                                            },
                                            child: Text(_buildBtnText(),
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  // Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Container(
                  //         height: 100,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           ClipRRect(
                  //             borderRadius: BorderRadius.circular(16),
                  //             child: Container(
                  //               width: 650,
                  //               height: 450,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.white10,
                  //                 borderRadius: BorderRadius.circular(16),
                  //                 // image: DecorationImage(
                  //                 //     fit: BoxFit.cover,
                  //                 //     image: AssetImage(_buildAnimateAsset()))
                  //               ),
                  //               child: Image.asset(
                  //                 _buildAnimateAsset(),
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           ),
                  //           Container(
                  //             padding: EdgeInsets.symmetric(vertical: 10),
                  //             width: 450,
                  //             height: 450,
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 // Text(
                  //                 //   'Step 1',
                  //                 //   style: TextStyle(
                  //                 //       fontSize: 34, color: AppColor.textDark1),
                  //                 // ),
                  //                 SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 Text(
                  //                   _buildText(),
                  //                   textAlign: TextAlign.start,
                  //                   style: TextStyle(
                  //                       fontSize: 28,
                  //                       color: AppColor.textDark1,
                  //                       overflow: TextOverflow.clip),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Container(
                  //         height: 150,
                  //         padding: EdgeInsets.symmetric(horizontal: 80),
                  //         child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.end,
                  //             children: [
                  //               SizedBox(),
                  //               ElevatedButton(
                  //                   style: ElevatedButton.styleFrom(
                  //                       fixedSize: Size(200, 80)),
                  //                   onPressed: () {
                  //                     handleUserGuild();
                  //                   },
                  //                   child: Text(
                  //                     _buildBtnText(),
                  //                     style: TextStyle(
                  //                         fontSize: 24, fontWeight: FontWeight.w400),
                  //                   ))
                  //             ]),
                  //       )
                  //     ],
                  //   )
                  : PrimmingIndicator(),
            ),
    );
  }

  String _buildBtnText() {
    switch (state) {
      case userguild2.complete:
        return 'จบการทำงาน';

      default:
    }
    return 'ถัดไป';
  }

  String _buildAnimateAsset() {
    switch (state) {
      case userguild2.releasePatientLine:
        return 'assets/image/demo.gif';
      case userguild2.releasedrainLine:
        return 'assets/image/demo.gif';
      case userguild2.complete:
        return 'assets/image/demo.gif';
    }
  }

  String _buildText() {
    switch (state) {
      case userguild2.releasePatientLine:
        return 'ล็อคสายที่ต่อเข้ากับช่องท้อง แล้วนำไปแขวนไว้ยังตำแหน่งที่กำหนด';

      case userguild2.releasedrainLine:
        return 'ถอดชุด Cassette และ ถุงน้ำยาไปทิ้ง';
      case userguild2.complete:
        return 'เสร็จสิ้น';
    }
  }
}









 

// class HandClean extends StatefulWidget {
//   const HandClean({super.key});

//   @override
//   State<HandClean> createState() => _HandCleanState();
// }

// class _HandCleanState extends State<HandClean> {
//   // VideoPlayerController? _controller;
//   bool isLoading = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = VideoPlayerController.asset('assets/video/demo.mp4')
//   //     ..initialize().then((_) {
//   //       _controller!.play();
//   //       _controller!.setLooping(true);
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     });
//   // }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _controller?.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     final provider = Provider.of<APDSystemProvider>(context, listen: false);
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                           width: 650,
//                           height: 450,
//                           decoration: BoxDecoration(
//                               color: Colors.white10,
//                               borderRadius: BorderRadius.circular(16),
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage('assets/image/demo.gif'))),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 1',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่ทำความสะอาดมือด้วยสบู่',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();
//                                 // _controller!.dispose();
//                                 // _controller == null;
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => SetupSolution()),
//                                 // );
//                                 Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     transitionDuration: Duration(milliseconds: 700),
//                                     pageBuilder: (context, animation,
//                                             secondaryAnimation) =>
//                                         SetupSolution(),
//                                     transitionsBuilder: (context, animation,
//                                         secondaryAnimation, child) {
//                                       const begin = Offset(1.0, 0.0);
//                                       const end = Offset.zero;
//                                       const curve = Curves.ease;
//                                       var tween = Tween(begin: begin, end: end)
//                                           .chain(CurveTween(curve: curve));
//                                       var offsetAnimation =
//                                           animation.drive(tween);
//                                       return SlideTransition(
//                                           position: offsetAnimation,
//                                           child: child);
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'ถัดไป',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }

//   // Widget _buildAlert() {
//   //   switch (context.watch<APDSystemProvider>().alertState) {
//   //     case AlertState.OVER_VOLUME:
//   //       return OverVolumeAlert();
//   //     case AlertState.VALVE_LEAK:
//   //       return OverVolumeAlert();
//   //     case AlertState.SLOWFLOW_LOW:
//   //       return OverVolumeAlert();
//   //     case AlertState.SLOWFLOW:
//   //       return OverVolumeAlert();

//   //     default:
//   //   }
//   //   return widget;
//   // }
// }

// class SetupSolution extends StatefulWidget {
//   const SetupSolution({super.key});

//   @override
//   State<SetupSolution> createState() => _SetupSolutionState();
// }

// class _SetupSolutionState extends State<SetupSolution> {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                             width: 650,
//                             height: 450,
//                             decoration: BoxDecoration(
//                                 color: Colors.white10,
//                                 borderRadius: BorderRadius.circular(16),
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image:
//                                         AssetImage('assets/image/demo.gif')))),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 2',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'แขวนถุงน้ำยา และวางถุงน้ำยาบน Heater',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();

//                                 // _controller == null;
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => InsertCasset()),
//                                 // );
//                                 Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     transitionDuration: Duration(milliseconds: 700),
//                                     pageBuilder: (context, animation,
//                                             secondaryAnimation) =>
//                                         InsertCasset(),
//                                     transitionsBuilder: (context, animation,
//                                         secondaryAnimation, child) {
//                                       const begin = Offset(1.0, 0.0);
//                                       const end = Offset.zero;
//                                       const curve = Curves.ease;
//                                       var tween = Tween(begin: begin, end: end)
//                                           .chain(CurveTween(curve: curve));
//                                       var offsetAnimation =
//                                           animation.drive(tween);
//                                       return SlideTransition(
//                                           position: offsetAnimation,
//                                           child: child);
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Next',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

// class InsertCasset extends StatefulWidget {
//   const InsertCasset({super.key});

//   @override
//   State<InsertCasset> createState() => _InsertCassetState();
// }

// class _InsertCassetState extends State<InsertCasset> {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                             width: 650,
//                             height: 450,
//                             decoration: BoxDecoration(
//                                 color: Colors.white10,
//                                 borderRadius: BorderRadius.circular(16),
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image:
//                                         AssetImage('assets/image/demo.gif')))),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 3',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'ติดตัง Cassete แขวนสายน้ำยาเข้าคนไว้ตำแหน่งที่กำหนด',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();

//                                 // _controller == null;
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => InsertDrainTank()),
//                                 // );
//                                 Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     transitionDuration: Duration(milliseconds: 700),
//                                     pageBuilder: (context, animation,
//                                             secondaryAnimation) =>
//                                         InsertDrainTank(),
//                                     transitionsBuilder: (context, animation,
//                                         secondaryAnimation, child) {
//                                       const begin = Offset(1.0, 0.0);
//                                       const end = Offset.zero;
//                                       const curve = Curves.ease;
//                                       var tween = Tween(begin: begin, end: end)
//                                           .chain(CurveTween(curve: curve));
//                                       var offsetAnimation =
//                                           animation.drive(tween);
//                                       return SlideTransition(
//                                           position: offsetAnimation,
//                                           child: child);
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Next',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

// class InsertDrainTank extends StatefulWidget {
//   const InsertDrainTank({super.key});

//   @override
//   State<InsertDrainTank> createState() => _InsertDrainTankState();
// }

// class _InsertDrainTankState extends State<InsertDrainTank> {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                             width: 650,
//                             height: 450,
//                             decoration: BoxDecoration(
//                                 color: Colors.white10,
//                                 borderRadius: BorderRadius.circular(16),
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image:
//                                         AssetImage('assets/image/demo.gif')))),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 4',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'วางถังน้ำยาทิ้งไว้ในตำแหนงที่กำหนดและต่อต่อท่อลม',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();
//                                 // _controller!.dispose();
//                                 // _controller == null;
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => InsertDrainLine()),
//                                 // );
//                                 Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     transitionDuration: Duration(milliseconds: 700),
//                                     pageBuilder: (context, animation,
//                                             secondaryAnimation) =>
//                                         InsertHeaterLine(),
//                                     transitionsBuilder: (context, animation,
//                                         secondaryAnimation, child) {
//                                       const begin = Offset(1.0, 0.0);
//                                       const end = Offset.zero;
//                                       const curve = Curves.ease;
//                                       var tween = Tween(begin: begin, end: end)
//                                           .chain(CurveTween(curve: curve));
//                                       var offsetAnimation =
//                                           animation.drive(tween);
//                                       return SlideTransition(
//                                           position: offsetAnimation,
//                                           child: child);
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Next',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

// class InsertDrainLine extends StatefulWidget {
//   const InsertDrainLine({super.key});

//   @override
//   State<InsertDrainLine> createState() => _InsertDrainLineState();
// }

// class _InsertDrainLineState extends State<InsertDrainLine> {
//   // VideoPlayerController? _controller;

//   // bool isLoading = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = VideoPlayerController.asset('assets/video/demo5.mp4')
//   //     ..initialize().then((_) {
//   //       _controller!.play();
//   //       _controller!.setVolume(0.0);
//   //       _controller!.setLooping(true);
//   //       _controller!.value.isBuffering;
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     });
//   // }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _controller?.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                           width: 650,
//                           height: 450,
//                           decoration: BoxDecoration(
//                             color: Colors.white10,
//                             borderRadius: BorderRadius.circular(16),
//                             image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage('assets/image/demo.gif')),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 5',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'สาย Drain ดึง Cap ติดตั้งสาย Drain เข้ากับถัง',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();
//                                 // _controller!.dispose();
//                                 // _controller == null;
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => InsertHeaterLine()),
//                                 // );
//                                 Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     transitionDuration: Duration(milliseconds: 700),
//                                     pageBuilder: (context, animation,
//                                             secondaryAnimation) =>
//                                         InsertHeaterLine(),
//                                     transitionsBuilder: (context, animation,
//                                         secondaryAnimation, child) {
//                                       const begin = Offset(1.0, 0.0);
//                                       const end = Offset.zero;
//                                       const curve = Curves.ease;
//                                       var tween = Tween(begin: begin, end: end)
//                                           .chain(CurveTween(curve: curve));
//                                       var offsetAnimation =
//                                           animation.drive(tween);
//                                       return SlideTransition(
//                                           position: offsetAnimation,
//                                           child: child);
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Next',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

// class InsertHeaterLine extends StatefulWidget {
//   const InsertHeaterLine({super.key});

//   @override
//   State<InsertHeaterLine> createState() => _InsertHeaterLineState();
// }

// class _InsertHeaterLineState extends State<InsertHeaterLine> {
//   // VideoPlayerController? _controller;

//   // bool isLoading = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = VideoPlayerController.asset('assets/video/demo5.mp4')
//   //     ..initialize().then((_) {
//   //       _controller!.play();
//   //       _controller!.setVolume(0.0);
//   //       _controller!.setLooping(true);
//   //       _controller!.value.isBuffering;
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     });
//   // }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _controller?.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                           width: 650,
//                           height: 450,
//                           decoration: BoxDecoration(
//                               color: Colors.white10,
//                               borderRadius: BorderRadius.circular(16),
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage('assets/image/demo.gif'))),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 6',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'สาย Heater ดึง Cap ต่อสายเข้ากับ Connector',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();
//                                 // _controller!.dispose();
//                                 // _controller == null;
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => InsertIcoLine()),
//                                 // );
//                                 Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     transitionDuration: Duration(milliseconds: 700),
//                                     pageBuilder: (context, animation,
//                                             secondaryAnimation) =>
//                                         InsertIcoLine(),
//                                     transitionsBuilder: (context, animation,
//                                         secondaryAnimation, child) {
//                                       const begin = Offset(1.0, 0.0);
//                                       const end = Offset.zero;
//                                       const curve = Curves.ease;
//                                       var tween = Tween(begin: begin, end: end)
//                                           .chain(CurveTween(curve: curve));
//                                       var offsetAnimation =
//                                           animation.drive(tween);
//                                       return SlideTransition(
//                                           position: offsetAnimation,
//                                           child: child);
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Next',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

// class InsertIcoLine extends StatefulWidget {
//   const InsertIcoLine({super.key});

//   @override
//   State<InsertIcoLine> createState() => _InsertIcoLineState();
// }

// class _InsertIcoLineState extends State<InsertIcoLine> {
//   // VideoPlayerController? _controller;

//   // bool isLoading = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = VideoPlayerController.asset('assets/video/demo5.mp4')
//   //     ..initialize().then((_) {
//   //       _controller!.play();
//   //       _controller!.setVolume(0.0);
//   //       _controller!.setLooping(true);
//   //       _controller!.value.isBuffering;
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     });
//   // }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _controller?.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                           width: 650,
//                           height: 450,
//                           decoration: BoxDecoration(
//                               color: Colors.white10,
//                               borderRadius: BorderRadius.circular(16),
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage('assets/image/demo.gif'))),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 7',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'สาย Ico ดึง Cap ต่อสายเข้ากับ Connector',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();
//                                 // _controller!.dispose();
//                                 // _controller == null;
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) =>
//                                 //           InsertSolutionLine()),
//                                 // );
//                                 Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     transitionDuration: Duration(milliseconds: 700),
//                                     pageBuilder: (context, animation,
//                                             secondaryAnimation) =>
//                                         InsertSolutionLine(),
//                                     transitionsBuilder: (context, animation,
//                                         secondaryAnimation, child) {
//                                       const begin = Offset(1.0, 0.0);
//                                       const end = Offset.zero;
//                                       const curve = Curves.ease;
//                                       var tween = Tween(begin: begin, end: end)
//                                           .chain(CurveTween(curve: curve));
//                                       var offsetAnimation =
//                                           animation.drive(tween);
//                                       return SlideTransition(
//                                           position: offsetAnimation,
//                                           child: child);
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Next',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

// class InsertSolutionLine extends StatefulWidget {
//   const InsertSolutionLine({super.key});

//   @override
//   State<InsertSolutionLine> createState() => _InsertSolutionLineState();
// }

// class _InsertSolutionLineState extends State<InsertSolutionLine> {
//   // VideoPlayerController? _controller;

//   // bool isLoading = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = VideoPlayerController.asset('assets/video/demo5.mp4')
//   //     ..initialize().then((_) {
//   //       _controller!.play();
//   //       _controller!.setVolume(0.0);
//   //       _controller!.setLooping(true);
//   //       _controller!.value.isBuffering;
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     });
//   // }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _controller?.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                           width: 650,
//                           height: 450,
//                           decoration: BoxDecoration(
//                               color: Colors.white10,
//                               borderRadius: BorderRadius.circular(16),
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage('assets/image/demo.gif'))),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 8',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'สายน้ำยา ดึง cap ต่อสายน้ำยาตามลำดับ กด cap ที่ไม่ได้ใช้ให้สนิท และหักสายน้ำยา',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();
//                                 // _controller!.dispose();
//                                 // _controller == null;
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           PrimmingIndicator()),
//                                 );
//                                 // Navigator.push(
//                                 //   context,
//                                 //   PageRouteBuilder(
//                                 //     transitionDuration: Duration(milliseconds: 700),
//                                 //     pageBuilder: (context, animation,
//                                 //             secondaryAnimation) =>
//                                 //         PrimmingIndicator(),
//                                 //     transitionsBuilder: (context, animation,
//                                 //         secondaryAnimation, child) {
//                                 //       const begin = Offset(1.0, 0.0);
//                                 //       const end = Offset.zero;
//                                 //       const curve = Curves.ease;
//                                 //       var tween = Tween(begin: begin, end: end)
//                                 //           .chain(CurveTween(curve: curve));
//                                 //       var offsetAnimation =
//                                 //           animation.drive(tween);
//                                 //       return SlideTransition(
//                                 //           position: offsetAnimation,
//                                 //           child: child);
//                                 //     },
//                                 //   ),
//                                 // );
//                               },
//                               child: Text(
//                                 'Next',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

// class ConnectPatientLine extends StatefulWidget {
//   const ConnectPatientLine({super.key});

//   @override
//   State<ConnectPatientLine> createState() => _ConnectPatientLineState();
// }

// class _ConnectPatientLineState extends State<ConnectPatientLine> {
//   // VideoPlayerController? _controller;

//   // bool isLoading = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = VideoPlayerController.asset('assets/video/demo5.mp4')
//   //     ..initialize().then((_) {
//   //       _controller!.play();
//   //       _controller!.setVolume(0.0);
//   //       _controller!.setLooping(true);
//   //       _controller!.value.isBuffering;
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     });
//   // }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _controller?.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         width: width,
//         height: height,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: FractionalOffset.topCenter,
//                 end: FractionalOffset.bottomCenter,
//                 stops: [0.0, 1.0],
//                 colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
//         child: context.watch<APDSystemProvider>().isError == true
//             ? BuildAlert()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 100,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: Container(
//                           width: 650,
//                           height: 450,
//                           decoration: BoxDecoration(
//                               color: Colors.white10,
//                               borderRadius: BorderRadius.circular(16),
//                               image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage('assets/image/demo.gif'))),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         width: 450,
//                         height: 450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Step 9',
//                               style: TextStyle(
//                                   fontSize: 34, color: AppColor.textDark1),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'เชื่อมต่อสาย Patient เข้ากลับ connector',
//                               style: TextStyle(
//                                   fontSize: 28,
//                                   color: AppColor.textDark1,
//                                   overflow: TextOverflow.clip),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.symmetric(horizontal: 80),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   fixedSize: Size(200, 80)),
//                               onPressed: () {
//                                 // _controller?.pause();
//                                 // _controller!.dispose();
//                                 // _controller == null;
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //       builder: (context) => MonitorTestPage()),
//                                 // );
//                                 Navigator.push(
//                                   context,
//                                   PageRouteBuilder(
//                                     transitionDuration: Duration(milliseconds: 700),
//                                     pageBuilder: (context, animation,
//                                             secondaryAnimation) =>
//                                         MonitorTestPage(),
//                                     transitionsBuilder: (context, animation,
//                                         secondaryAnimation, child) {
//                                       const begin = Offset(1.0, 0.0);
//                                       const end = Offset.zero;
//                                       const curve = Curves.ease;
//                                       var tween = Tween(begin: begin, end: end)
//                                           .chain(CurveTween(curve: curve));
//                                       var offsetAnimation =
//                                           animation.drive(tween);
//                                       return SlideTransition(
//                                           position: offsetAnimation,
//                                           child: child);
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Start',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w400),
//                               ))
//                         ]),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }
