
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';

import 'mock_blue_device.dart';

class MockFlutterBlueProvider {

  final List<BTDevice> devices = [];

  BehaviorSubject<List<BTDevice>> _btDeviceStream = BehaviorSubject<List<BTDevice>>();

  Stream<List<BTDevice>> getDeviceList() => _btDeviceStream;

  MockFlutterBlueProvider();

  void addDevice(BTDevice btDevice) {
    if (_btDeviceStream == null || _btDeviceStream.isClosed) {
      _btDeviceStream = BehaviorSubject<List<BTDevice>>();
      _btDeviceStream.add(devices);
    }
    devices.add(btDevice);
    _btDeviceStream.add(devices);
  }

  Future<dynamic> doDone() async {
//    devices.clear();
    return _btDeviceStream.close();
  }

  Future<void> addDelay(int milliseconds) {
    return Future.delayed(Duration(milliseconds: milliseconds), () => null);
  }

  Future<void> doNothing() async {
    return Future.value(null);
  }

  void doError() {
    return _btDeviceStream.addError('An error has occurred');
  }

//  Stream<List<BTDevice>> getDeviceList() async* {
//    final List<BTDevice> devices = [];
//    for (int i = 0; i < 3; i++) {
//      final btDevice = MockBlueDevice();
//      devices.add(btDevice);
//      yield devices;
//    }
//  }

}