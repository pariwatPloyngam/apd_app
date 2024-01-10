// ignore_for_file: avoid_print, non_constant_identifier_names, constant_identifier_names, unrelated_type_equality_checks

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

enum APDDeviceState {
  APD_OK,
  APD_BUSY,
  APD_ERROR,
}

enum SerialConnectionState {
  DISCONNECTED,
  CONNECTING,
  CONNECTED,
}

enum APDState {
  NONE,
  STANDBY,
  IDRAIN,
  PRIMMING,
  DRAIN,
  FILL,
  DWELL,
  LASTFILL,
  PAUSE,
  COMPLETE
}

enum AlertState {
  NONE,
  OVER_VOLUME,
  VALVE_LEAK,
  SLOWFLOW_LOW,
  SLOWFLOW,
}

class APDSystemProvider with ChangeNotifier {
  UsbPort? _mainBoardPort;
  // UsbDevice? _mainBoard;

  StreamSubscription<Uint8List>? _mainSubscription;
  Transaction<Uint8List>? _mainTransaction;

  SerialConnectionState _connectionState = SerialConnectionState.CONNECTING;
  SerialConnectionState get connectionState => _connectionState;

  double mapValue(
      double value, double start1, double stop1, double start2, double stop2) {
    return ((value - start1) / (stop1 - start1)) * (stop2 - start2) + start2;
  }

/* SET PARAMETER PORT */
  int mainbaudRate = 115200;
  int dataBits = UsbPort.DATABITS_8;
  int stopBits = UsbPort.STOPBITS_1;
  int parity = UsbPort.PARITY_NONE;

  int get solutionRem => _totalVol - _totalFillVol;

  bool _onprimming = false;
  bool get onprimming => _onprimming;
  set onprimming(bool value) {
    _onprimming = value;
    notifyListeners();
  }

  bool _heater = false;
  bool get heater => _heater;
  set heater(bool value) {
    _heater = value;
    notifyListeners();
  }

  bool _isError = false;
  bool get isError => _isError;
  set isError(bool value) {
    _isError = value;
    notifyListeners();
  }

  bool _primDone = false;
  bool get primDone => _primDone;
  set primDone(bool endPrim) {
    _primDone = endPrim;
    notifyListeners();
  }

  Map<String, dynamic>? _profile;
  Map<String, dynamic>? get profile => _profile;
  void setProfile(Map<String, dynamic> newProfile) {
    _profile = newProfile;
    _totalVol = newProfile["totalVol"];
    _idrainVol = newProfile["idrainVol"];
    _lastFillVol = newProfile["lastFillVol"];
    _fillVol = newProfile["fillVol"];
    _drainVol = newProfile["fillVol"];
    notifyListeners();
  }

  int _totalVol = 0;
  int get totalVol => _totalVol;
  void setTotalVol(int tv) {
    _totalVol = tv;
    notifyListeners();
  }

  int _totalDrainVol = 0;
  int get totalDrainVol => _totalDrainVol;
  set totalDrainVol(int value) {
    _totalDrainVol = value;
    notifyListeners();
  }

  int _drainVol = 0;
  int get drainVol => _drainVol;
  set drainVol(int value) {
    _drainVol = value;
    notifyListeners();
  }

  int _fillVol = 0;
  int get fillVol => _fillVol;
  set fillVol(int value) {
    _fillVol = value;
    notifyListeners();
  }

  int _lastFillVol = 0;
  int get lastFillVol => _lastFillVol;
  set lastFillVol(int value) {
    _lastFillVol = value;
    notifyListeners();
  }

  int _idrainVol = 0;
  int get idrainVol => _idrainVol;
  set idrainVol(int value) {
    if (_apdState == APDState.IDRAIN) {
      _idrainVol = value;
    }

    notifyListeners();
  }

  int _totalFillVol = 0;
  int get totalFillVol => _totalFillVol;
  set totalFillVol(int value) {
    _totalFillVol = value;
    notifyListeners();
  }

  double _heaterTemp = 0;
  double get heaterTemp => _heaterTemp;
  set heaterTemp(double newTemp) {
    _heaterTemp = newTemp;
    notifyListeners();
  }

  double _solutionTemp = 0;
  double get solutionTemp => _solutionTemp;
  set solutionTemp(double newTemp) {
    _solutionTemp = newTemp;
    notifyListeners();
  }

  int _upperWeight = 0;
  int get upperWeight => _upperWeight;
  set upperWeight(int newWeight) {
    _upperWeight = newWeight;
    notifyListeners();
  }

  int _drainTankWeight = 0;
  int get drainTankWeight => _drainTankWeight;
  set drainTankWeight(int dw) {
    _drainTankWeight = dw;
    notifyListeners();
  }

  double _pressure = 0;
  double get pressure => _pressure;
  set pressure(double newpressure) {
    _pressure = newpressure;
    notifyListeners();
  }

  int _currentCycle = 0;
  int get currentCycle => _currentCycle;
  set currentCycle(int value) {
    _currentCycle = value;
    notifyListeners();
  }

  int _totalCycle = 0;
  int get totalCycle => _totalCycle;
  set totalCycle(int value) {
    _totalCycle = value;
    notifyListeners();
  }

  int _progress = 0;
  int get progress => _progress;
  set progress(int prog) {
    _progress = prog;
    notifyListeners();
  }

  int _target = 0;
  int get target => _target;
  set target(int value) {
    _target = value;
    notifyListeners();
  }

  int _dwellTime = 0;
  int get dwellTime => _dwellTime;
  set dwellTime(int value) {
    _dwellTime = value;
    notifyListeners();
  }

  double _primProgress = 0;
  double get primProgress => _primProgress;
  set primProgress(double pprog) {
    _primProgress = pprog;
    notifyListeners();
  }

  int _totalTime = 0;
  int get totalTime => _totalTime;
  set totalTime(int value) {
    if (apdState != APDState.COMPLETE) {
      _totalTime = value;
      notifyListeners();
    }
  }

  int _profit = 0;
  int get profit => _profit;
  set profit(int value) {
    int prevProfit = 0;
    if (_apdState == APDState.DRAIN) {
      prevProfit = value;
    }
    _profit = prevProfit;
    notifyListeners();
  }

  APDState _apdState = APDState.NONE;
  APDState get apdState => _apdState;
  set apdState(APDState state) {
    _apdState = state;
    notifyListeners();
  }

  set state(int newstate) {
    switch (newstate) {
      case 0:
        apdState = APDState.NONE;
      case 1:
        apdState = APDState.STANDBY;
      case 2:
        apdState = APDState.IDRAIN;
      case 3:
        apdState = APDState.PRIMMING;
      case 4:
        apdState = APDState.DRAIN;
      case 5:
        apdState = APDState.FILL;
      case 6:
        apdState = APDState.DWELL;
      case 7:
        apdState = APDState.LASTFILL;
      case 8:
        apdState = APDState.PAUSE;
      case 9:
        apdState = APDState.COMPLETE;
      default:
    }
    notifyListeners();
  }

  AlertState _alertState = AlertState.NONE;
  AlertState get alertState => _alertState;
  set alertState(AlertState alert) {
    _alertState = alert;

    notifyListeners();
  }

  set alert(int newstate) {
    switch (newstate) {
      case 100:
        alertState = AlertState.OVER_VOLUME;
        break;
      case 101:
        alertState = AlertState.VALVE_LEAK;
        break;
      case 102:
        alertState = AlertState.SLOWFLOW_LOW;
        break;
      case 103:
        alertState = AlertState.SLOWFLOW;
        break;
      default:
        alertState = AlertState.NONE;
    }
  }

  void init() {
    print('init serial provider.');
    print('device ${connectionState.name.toLowerCase()}...');
    _apdState = APDState.NONE;
    _alertState = AlertState.NONE;
    if (_connectionState == SerialConnectionState.CONNECTED) return;
    UsbSerial.usbEventStream?.listen((event) {
      if (event.event == UsbEvent.ACTION_USB_ATTACHED) {
        _connectionState = SerialConnectionState.CONNECTING;
        notifyListeners();
        Future.delayed(const Duration(seconds: 3), () {
          _getPorts();
        });
      } else {
        _connectionState = SerialConnectionState.DISCONNECTED;
        notifyListeners();
        print('device ${connectionState.name.toLowerCase()}!');
      }
    });
    Future.delayed(const Duration(seconds: 10), () {
      _getPorts();
    });
  }

  void _getPorts() async {
    var devices = await UsbSerial.listDevices();
    // print("devices = $devices");

    if (devices.isNotEmpty) {
      UsbDevice device = devices.firstWhere((element) => element.vid == 9025,
          orElse: () => UsbDevice('deviceName', 0, 0, "productName",
              "manufacturerName", 0, "serial", 0));

      if (device.vid == 9025) {
        _connectToMainBoard(device);
      } else if (device.vid == 0) {
        _connectionState = SerialConnectionState.DISCONNECTED;
        notifyListeners();
        print(
            'device ${connectionState.name.toLowerCase()} *device not support');
      }
    }
  }

  Future<bool> _connectToMainBoard(UsbDevice device) async {
    _connectionState = SerialConnectionState.CONNECTING;
    notifyListeners();

    if (_mainBoardPort != null) {
      _mainBoardPort!.close();
      _mainBoardPort = null;
    }

    if (_mainSubscription != null) {
      _mainSubscription?.cancel();
      _mainSubscription = null;
    }

    if (_mainTransaction != null) {
      _mainTransaction?.dispose();
      _mainTransaction = null;
    }

    _mainBoardPort = await device.create();
    await _mainBoardPort!.open();
    if (await (_mainBoardPort!.open()) != true) {
      _connectionState = SerialConnectionState.DISCONNECTED;
      notifyListeners();

      print("Failed to open port");

      return false;
    }

    await _mainBoardPort!.setDTR(true);
    await _mainBoardPort!.setRTS(true);
    await _mainBoardPort!
        .setPortParameters(mainbaudRate, dataBits, stopBits, parity);

    _mainTransaction = Transaction.terminated(
        _mainBoardPort!.inputStream!, Uint8List.fromList([0x55, 0x0D, 0x0A]));

    _mainSubscription = _mainTransaction!.stream.listen((data) {
      var dataList = Uint8List.fromList(data);
      // print(dataList);
      // print('Total Solutions $totalVol');
      // print('Solutions Rem $solutionRem');
      if (dataList[3] == 0x02) {
        upperWeight = dataList.buffer.asByteData().getUint16(4);
        drainTankWeight = dataList.buffer.asByteData().getUint16(6);
        heaterTemp = dataList.buffer.asByteData().getFloat32(8, Endian.little);
        solutionTemp =
            dataList.buffer.asByteData().getFloat32(12, Endian.little);
        pressure = dataList.buffer.asByteData().getFloat32(16, Endian.little);
        state = dataList.buffer.asByteData().getInt8(20);
        currentCycle = dataList.buffer.asByteData().getInt8(21);
        totalCycle = dataList.buffer.asByteData().getInt8(22);
        progress = dataList.buffer.asByteData().getInt16(23);
        target = dataList.buffer.asByteData().getInt16(25);
        totalDrainVol = dataList.buffer.asByteData().getInt16(29);
        idrainVol = dataList.buffer.asByteData().getInt16(29);
        totalFillVol = dataList.buffer.asByteData().getInt16(27);
        totalTime = dataList.buffer.asByteData().getInt16(31);

        // if (_apdState == APDState.DRAIN) {
        //   profit = (_totalDrainVol - _totalFillVol) - _idrainVol;
        // }
        if (_apdState == APDState.FILL ) {
          if (_totalCycle > 0){
            _profit = (_totalDrainVol - _totalFillVol) - _idrainVol;
          }
          
        }

        if (isError == false) {
          alertState = AlertState.NONE;
        }
      } else if (dataList[3] == 0x14) {
        int primm_prog = dataList.buffer.asByteData().getInt16(4);
        primProgress = mapValue(primm_prog.toDouble(), 0, 19039, 0, 1);

        print('Primming Progress $primProgress');
      } else if (dataList[3] == 0x22) {
        onprimming = false;
      } else if (dataList[3] == 0x90) {
        Future.delayed(const Duration(seconds: 1), () {
          isError = true;
          alert = dataList.buffer.asByteData().getInt8(4);
        });
      }
      print('State : ${apdState.name}');
      print('Error : ${alertState.name}');
      print('');
    });

    print('Main Devices = ${device.manufacturerName}');
    _connectionState = SerialConnectionState.CONNECTED;
    notifyListeners();
    print('device ${connectionState.name.toLowerCase()}');
    print('Self Test ');
    await startSelfTest();
    _apdState = APDState.NONE;
    return true;
  }

// Command Manager
  Future getDataSensors() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0x02], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future startApdWithProfile() async {
    List<int> cmd = List.from([0x56, 0x55, 0x10, 0x60], growable: true);
    int tv1 = (_profile?['totalVol'] >> 8) & 0xFF;
    int tv2 = _profile?['totalVol']! & 0xFF;
    int idv1 = (_profile?['idrainVol']! >> 8) & 0xFF;
    int idv2 = _profile?['idrainVol']! & 0xFF;
    int idvMin = _profile?['idrainMin']! & 0xFF; ////////////////
    int fv1 = (_profile?['fillVol']! >> 8) & 0xFF;
    int fv2 = _profile?['fillVol']! & 0xFF;
    int fvMin = _profile?['fillMin']! & 0xFF; /////////////////
    int dMin = _profile?['drainMin']! & 0xFF; ////////////////
    int lfv1 = (_profile?['lastFillVol']! >> 8) & 0xFF;
    int lfv2 = _profile?['lastFillVol']! & 0xFF;
    int lfvMin = _profile?['lastFillMin']! & 0xFF; //////////////
    int ico = _profile?['ico'] == 0 ? 0x00 : 0x01;
    int dur1 = (_profile?['time']! >> 8) & 0xFF;
    int dur2 = _profile?['time']! & 0xFF;
    // tvol = _profile?['totalVol'];
    cmd.addAll([
      tv1,
      tv2,
      idv1,
      idv2,
      idvMin,
      fv1,
      fv2,
      fvMin,
      dMin,
      lfv1,
      lfv2,
      lfvMin,
      ico,
      dur1,
      dur2
    ]);

    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    String hexString =
        cmd.map((dynamic byte) => byte.toRadixString(16)).join(' ');
    print('Command Hex ===> ${hexString.toUpperCase()}');
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future confirmStart() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0x70], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future initAllValve() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0x10], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future openAllValve() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0x17], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future closeAllValve() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0x16], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future allValveHome() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0x42], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future closeHeater() async {
    List<int> cmd = List.from([0x56, 0x55, 0x02, 0x50, 0x00], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future openHeater() async {
    List<int> cmd = List.from([0x56, 0x55, 0x02, 0x50, 0x01], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future startSelfTest() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0x04, 0x06], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future startPrimming() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0xA1, 0xA3], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  Future startDrain() async {
    List<int> cmd = List.from([0x56, 0x55, 0x01, 0xA2, 0xA0], growable: true);
    var crc = 0;
    for (var d in cmd) {
      crc ^= d;
    }
    cmd.addAll([crc, 0x0D, 0x0A]);
    await apdWriteCmd(Uint8List.fromList(cmd));
  }

  // Future v1() async {
  //   List<int> cmd =
  //       List.from([0x56, 0x55, 0x04, 0x40, 0x81, 0X03, 0xEB], growable: true);
  //   var crc = 0;
  //   for (var d in cmd) {
  //     crc ^= d;
  //   }
  //   cmd.addAll([crc, 0x0D, 0x0A]);
  //   await apdWriteCmd(Uint8List.fromList(cmd));
  // }

  // Future v2() async {
  //   List<int> cmd =
  //       List.from([0x56, 0x55, 0x04, 0x40, 0x82, 0X03, 0xEB], growable: true);
  //   var crc = 0;
  //   for (var d in cmd) {
  //     crc ^= d;
  //   }
  //   cmd.addAll([crc, 0x0D, 0x0A]);
  //   await apdWriteCmd(Uint8List.fromList(cmd));
  // }

//  Send Command to MCU with Function
  Future<APDDeviceState> apdWriteCmd(Uint8List cmd) async {
    if (_connectionState == SerialConnectionState.DISCONNECTED) {
      return APDDeviceState.APD_ERROR;
    }

    if (_mainBoardPort == null || _mainTransaction == null) {
      return APDDeviceState.APD_ERROR;
    }

    print('Send Command ===> $cmd');
    // _isBusy = true;
    notifyListeners();

    dynamic response = (await _mainTransaction?.transaction(
        _mainBoardPort!, cmd, const Duration(seconds: 10)));

    // _isBusy = false;
    // notifyListeners();

    // var bytes = utf8.encode(response);

    // String hexString =
    //     bytes.map((dynamic byte) => byte.toRadixString(16)).join(' ');

    // print('Response Dec <=== $bytes');
    // print('Response Hex <=== ${hexString.toUpperCase()}');
    // print('Response Str <=== $response');
    print(
        '------------------------------------------------------------------------------------------------------------------------------');

    if (response == null) {
      return APDDeviceState.APD_ERROR;
    }

    if (response.length == 2) {
      int resCode = response.buffer.asByteData().getUint16(0);
      print('state :$resCode');
      if (resCode != 2) {
        return APDDeviceState.APD_BUSY;
      } else {
        return APDDeviceState.APD_OK;
      }
    } else if (response.length == 13 || response.length == 10) {
      return APDDeviceState.APD_OK;
    } else {
      // print('device not apd');
      return APDDeviceState.APD_ERROR;
    }
    // return response;
  }
}
