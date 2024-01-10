// /* install lib usb_serial: ^0.4.0
// 1. go to >> android\app\src\main\AndroidManifest.xml
//   add
//       <intent-filter>
//         <action android:name="android.intent.action.MAIN"/>
//         <category android:name="android.intent.category.LAUNCHER"/>
//       </intent-filter>

//       <intent-filter>
//           <action android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED" />
//       </intent-filter>

//       <meta-data android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED"
//           android:resource="@xml/device_filter" />
// -------------------------------------------------------------------------------
// 2. android\app\src\main\res\xml\device_filter.xml
//   -> new folder xml  and new file device_filter.xml
//   add
// <?xml version="1.0" encoding="utf-8"?>
// <resources>
//     <!-- 0x0403 / 0x6001: FTDI FT232R UART -->
//     <usb-device vendor-id="0403" product-id="6001" />

//     <!-- 0x0403 / 0x6015: FTDI FT231X -->
//     <usb-device vendor-id="1027" product-id="24597" />

//     <!-- 0x2341 / Arduino -->
//     <usb-device vendor-id="9025" />

//     <!-- 0x16C0 / 0x0483: Teensyduino  -->
//     <usb-device vendor-id="5824" product-id="1155" />

//     <!-- 0x10C4 / 0xEA60: CP210x UART Bridge -->
//     <usb-device vendor-id="4292" product-id="60000" />

//     <!-- 0x067B / 0x2303: Prolific PL2303 -->
//     <usb-device vendor-id="1659" product-id="8963" />

//     <!-- 0x1366 / 0x0105: Segger JLink -->
//     <usb-device vendor-id="4966" product-id="261" />

//     <!-- 0x1366 / 0x0105: CH340 JLink -->
//     <usb-device vendor-id="1A86" product-id="7523" />

// </resources>
// -------------------------------------------------------------------------------
// 3. run code
// */

// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/screen/complete_screen.dart';
import 'package:apd_app/screen/control.dart';
import 'package:apd_app/screen/home_screen.dart';
import 'package:apd_app/screen/monitor_dev.dart';
import 'package:apd_app/screen/monitor.dart';
import 'package:apd_app/screen/user_guide.dart';
import 'package:apd_app/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // UsbDeviceReceiver usbDeviceReceiver = UsbDeviceReceiver(
  //   onUsbDeviceAttached: () {
  //     // Handle USB device attached event here
  //     print('USB device attached!');
  //   },
  // );
  // usbDeviceReceiver.register();
  runApp(ChangeNotifierProvider(
    create: (context) => APDSystemProvider(),
    child: MyApp(),
  )
      // runApp(const MyApp());
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    context.read<APDSystemProvider>().init();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Style(),
      home: HomePage(),
      // home: MonitorDevPage(),
      // home: MonitorPage(),
      // home: UserGuide(),
      
      // home: ControlPage(),
      // home: CompleteScreen(),
    );
  }
}
