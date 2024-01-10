// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:apd_app/provider/apd_system.dart';
// import 'package:apd_app/styles/color.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';

// class BuildAlert extends StatefulWidget {
//   const BuildAlert({super.key});

//   @override
//   State<BuildAlert> createState() => _BuildAlertState();
// }

// class _BuildAlertState extends State<BuildAlert> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<APDSystemProvider>(context, listen: false);
//     return Expanded(child: _buildAlert(provider.alertState));
//   }

//   Widget _buildAlert(AlertState alertState) {
//     switch (alertState) {
//       case AlertState.OVER_VOLUME:
//         return OverVolumeAlert();
//       case AlertState.VALVE_LEAK:
//         return ValveLeak();
//       case AlertState.SLOWFLOW_LOW:
//         return SlowFlowLowAlert();
//       case AlertState.SLOWFLOW:
//         return SlowFlowAlert();

//       default:
//     }
//     return widget;
//   }
// }

// class OverVolumeAlert extends StatelessWidget {
//   const OverVolumeAlert({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white.withOpacity(.05),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//           side: BorderSide(width: 1, color: Colors.white10)),
//       content: Container(
//         // color: Colors.white10,
//         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//         width: 1100,
//         height: 550,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   width: 400,
//                   height: 400,
//                   // color: Colors.white10,
//                   child: Lottie.asset('assets/animation/warning_animation.json',
//                       fit: BoxFit.cover),
//                   //     Icon(
//                   //   Icons.warning_rounded,
//                   //   size: 400,
//                   //   color: Colors.amber,
//                   // )
//                 ),
//                 Container(
//                   width: 600,
//                   height: 400,
//                   // color: Colors.white10,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'แจ้งเตือน !',
//                         style: TextStyle(
//                             fontSize: 60,
//                             color: AppColor.textDark1,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         'กรุณาตรวจสอบว่าไม่มีอะไรวางอยู่บนเครื่องชั่ง',
//                         style:
//                             TextStyle(fontSize: 36, color: AppColor.textDark1),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(fixedSize: Size(200, 80)),
//                     onPressed: () {
//                       context.read<APDSystemProvider>().isError = false;
//                     },
//                     child: Text(
//                       'ยืนยัน',
//                       style: TextStyle(
//                         fontSize: 24,
//                       ),
//                     )))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ValveLeak extends StatelessWidget {
//   const ValveLeak({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white.withOpacity(.05),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//           side: BorderSide(width: 1, color: Colors.white10)),
//       content: Container(
//         // color: Colors.white10,
//         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//         width: 1100,
//         height: 550,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   width: 400,
//                   height: 400,
//                   // color: Colors.white10,
//                   child:
//                       Lottie.asset('assets/animation/warning_animation.json'),
//                 ),
//                 Container(
//                   width: 600,
//                   height: 400,
//                   // color: Colors.white10,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'แจ้งเตือน !',
//                         style:
//                             TextStyle(fontSize: 50, color: AppColor.textDark1),
//                       ),
//                       Text(
//                         'มีการรั่วของวาล์ว อาจทำให้เกิดอันตรายได้',
//                         style:
//                             TextStyle(fontSize: 36, color: AppColor.textDark1),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(fixedSize: Size(200, 80)),
//                     onPressed: () {
//                       context.read<APDSystemProvider>().isError = false;
//                     },
//                     child: Text(
//                       'ยืนยัน',
//                       style: TextStyle(
//                         fontSize: 24,
//                       ),
//                     )))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SlowFlowLowAlert extends StatelessWidget {
//   const SlowFlowLowAlert({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<APDSystemProvider>(context, listen: false);
//     return provider.apdState == APDState.DRAIN ||
//             provider.apdState == APDState.IDRAIN
//         ? AlertDialog(
//             backgroundColor: Colors.white.withOpacity(.05),
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 side: BorderSide(width: 1, color: Colors.white10)),
//             content: Container(
//               // color: Colors.white10,
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//               width: 1100,
//               height: 550,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: 400,
//                         height: 400,
//                         // color: Colors.white10,
//                         child: Lottie.asset(
//                             'assets/animation/warning_animation.json'),
//                       ),
//                       Container(
//                         width: 600,
//                         height: 400,
//                         // color: Colors.white10,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'แจ้งเตือน !',
//                               style: TextStyle(
//                                   fontSize: 50, color: AppColor.textDark1),
//                             ),
//                             Text(
//                               'Slow flow in ${provider.apdState.name} กรุณาขยับตัว',
//                               style: TextStyle(
//                                   fontSize: 36, color: AppColor.textDark1),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               fixedSize: Size(200, 80)),
//                           onPressed: () {
//                             context.read<APDSystemProvider>().isError = false;
//                           },
//                           child: Text(
//                             'ยืนยัน',
//                             style: TextStyle(
//                               fontSize: 24,
//                             ),
//                           )))
//                 ],
//               ),
//             ),
//           )
//         : AlertDialog(
//             backgroundColor: Colors.white.withOpacity(.05),
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 side: BorderSide(width: 1, color: Colors.white10)),
//             content: Container(
//               // color: Colors.white10,
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//               width: 1100,
//               height: 550,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: 400,
//                         height: 400,
//                         // color: Colors.white10,
//                         child: Lottie.asset(
//                             'assets/animation/warning_animation.json'),
//                       ),
//                       Container(
//                         width: 600,
//                         height: 400,
//                         // color: Colors.white10,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'แจ้งเตือน !',
//                               style: TextStyle(
//                                   fontSize: 50, color: AppColor.textDark1),
//                             ),
//                             Text(
//                               'Slow flow in ${provider.apdState.name} กรุณาขยับตัว',
//                               style: TextStyle(
//                                   fontSize: 36, color: AppColor.textDark1),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               fixedSize: Size(200, 80)),
//                           onPressed: () {
//                             context.read<APDSystemProvider>().isError = false;
//                           },
//                           child: Text(
//                             'ยืนยัน',
//                             style: TextStyle(
//                               fontSize: 24,
//                             ),
//                           )))
//                 ],
//               ),
//             ),
//           );
//   }
// }

// class SlowFlowAlert extends StatelessWidget {
//   const SlowFlowAlert({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<APDSystemProvider>(context, listen: false);
//     return AlertDialog(
//       backgroundColor: Colors.white.withOpacity(.05),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//           side: BorderSide(width: 1, color: Colors.white10)),
//       content: Container(
//         // color: Colors.white10,
//         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//         width: 1100,
//         height: 550,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   width: 400,
//                   height: 400,
//                   // color: Colors.white10,
//                   child:
//                       Lottie.asset('assets/animation/warning_animation.json'),
//                 ),
//                 Container(
//                   width: 600,
//                   height: 400,
//                   // color: Colors.white10,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'แจ้งเตือน !',
//                         style:
//                             TextStyle(fontSize: 50, color: AppColor.textDark1),
//                       ),
//                       Text(
//                         'Slow flow in ${provider.apdState.name}',
//                         style:
//                             TextStyle(fontSize: 36, color: AppColor.textDark1),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(fixedSize: Size(200, 80)),
//                     onPressed: () {
//                       context.read<APDSystemProvider>().isError = false;
//                     },
//                     child: Text(
//                       'ยืนยัน',
//                       style: TextStyle(
//                         fontSize: 24,
//                       ),
//                     )))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({
    super.key,
  });

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  // final player = AudioPlayer();
  // String path = 'assets/sounds/alert.wav';
  // void play() async {
  //   await player.setAsset(path);
  //   await player.play();
  //   await player.setLoopMode(LoopMode.one);
  //   await player.setSpeed(1.15);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   play();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   player.stop();
  //   player.dispose();
  // }

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
    _playAudio();
  }

  Future<void> _initAudioPlayer() async {
    await _audioPlayer.setAsset(
        'assets/sounds/alert.wav'); // Replace with your audio file path
    _audioPlayer.setLoopMode(LoopMode.one);
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.stop();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black45,
      child: AlertDialog(
        actionsPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 80, 40),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: BorderSide(color: Colors.amber, width: 5)),
        backgroundColor: AppColor.darkPrimary,
        content: Container(
          width: 1000,
          height: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300,
                height: 300,
                // color: Colors.white10,
                child: Lottie.asset(
                  'assets/animation/warning_animation.json',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 500,
                height: 350,
                // color: Colors.white10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'แจ้งเตือน',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _buildText(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 34, color: AppColor.textDark1),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            // color: Colors.white10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                provider.alertState == AlertState.OVER_VOLUME
                    ? SizedBox()
                    : TextButton(
                        child: const Text(
                          'จบการทำงาน',
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          // Add your custom action here
                          Future.delayed(const Duration(milliseconds: 1200), () {
                            context.read<APDSystemProvider>().isError = false;
                            context.read<APDSystemProvider>().alertState =
                                AlertState.NONE;
                          });
                        },
                      ),
                SizedBox(
                  width: 50,
                ),
                TextButton(
                  child: Text(
                    _buildBtn(),
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 1200), () {
                      context.read<APDSystemProvider>().isError = false;
                      context.read<APDSystemProvider>().alertState =
                          AlertState.NONE;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildText() {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    String text = '';
    if (provider.alertState == AlertState.OVER_VOLUME) {
      text =
          'ตรวจสอบว่ามีสิ่งของวางอยู่บนแท่นวางถุงน้ำยาหรือถึงน้ำยาทิ้งหรือไม่ ถ้ามีโปรดเอาออก แล้วกด "ตกลง"';
    } else if (provider.alertState == AlertState.VALVE_LEAK) {
      text = 'มีการรั่วไหลของน้ำยา ซึ่งอาจทำให้เกิดอันตราย กรุณาหยุดการทำงาน';
    } else if (provider.alertState == AlertState.SLOWFLOW) {
      if (provider.apdState == APDState.DRAIN ||
          provider.apdState == APDState.IDRAIN) {
        text =
            'การระบายออกช้ากว่าปกติ กรุณาขยับตัว หือตรวจสอบว่ามีการพับของสายหรือไม่ แล้วกด "ตกลง"';
      } else {
        text =
            'การเติมน้ำยาเข้าช้ากว่าปกติ กรุณาขยับตัว หือตรวจสอบว่ามีการพับของสายหรือไม่ แล้วกด "ตกลง"';
      }
    } else if (provider.alertState == AlertState.SLOWFLOW_LOW) {
      if (provider.apdState == APDState.DRAIN ||
          provider.apdState == APDState.IDRAIN) {
        text =
            'การระบายออกช้ากว่าปกติ กรุณาขยับตัว หือตรวจสอบว่ามีการพับของสายหรือไม่ แล้วกด "ตกลง"';
      } else {
        text =
            'การเติมน้ำยาเข้าช้ากว่าปกติ กรุณาขยับตัว หือตรวจสอบว่ามีการพับของสายหรือไม่ แล้วกด "ตกลง"';
      }
    }
    return text;
  }

  String _buildBtn() {
    switch (context.watch<APDSystemProvider>().alertState) {
      case AlertState.OVER_VOLUME:
        return 'ตกลง';
      case AlertState.VALVE_LEAK:
        return 'ทำต่อ';
      case AlertState.SLOWFLOW:
        return 'ทำต่อ';
      case AlertState.SLOWFLOW_LOW:
        return 'ทำต่อ';
      default:
    }
    return '';
  }
}
