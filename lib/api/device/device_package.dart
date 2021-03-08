

import 'dart:async';
import 'dart:ui';
import 'package:rxdart/rxdart.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';

import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/bt_device_controller.dart';

import '../../injection_container.dart';
import 'identifiers.dart';

abstract class Device {
  
  final DeviceID _id;
  final String _name;
  final DeviceType _type;
  // final _state = BehaviorSubject<DeviceState>()..startWith(DeviceState.notFound);
  //BTDevice _btDevice;
  final BTDeviceController _btDeviceController = BTDeviceController(sl<BluetoothProvider>());

  Device(this._id, this._name, this._type);

  Future<void> initBluetooth() async => await _btDeviceController.load(_id);


  DeviceID get id => _id;
  String get name => _name;
  DeviceType get type => _type;
  //Stream<DeviceState> get state => _state.stream;

  //BTDevice get btDevice => _btDeviceController.btDevice;

  Stream<DeviceState> get state => _btDeviceController.btState.map((btState) => _mapBTStateToDeviceState(btState));


  // set btDevice(BTDevice btDevice) {
  //   _btDevice = btDevice;
  //   if (_btDevice != null) {
  //     // _btDevice.ensureConnection(
  //     //   onConnect: () {
  //     //     print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] ** Device is connected');
  //     //   },
  //     //   onConnectionLost: () {
  //     //     print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] ** Device Connection lost');
  //     //   }
  //     // );
  //   } else {
  //     // _startDeviceSearch(
  //     //   onFound: () {

  //     //   }
  //     // );
  //   }
  // }

  // void _checkConnection(BTDeviceState btDeviceState) {
  //   final newState = _transformBTStateToDeviceState(btDeviceState);
  //   if (_isConnectionLost(newState)) {
  //     _reconnect();
  //   }
  //   _state.add(newState);
  // }

  // void _startDeviceSearch({@required Function onFound}) {
  //   Timer.periodic(
  //     Duration(seconds: 5), 
  //     (timer) {

        // _btDevice.connect()
        //           .then((_) {
        //             print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Device continue connected');
        //           })
        //           .timeout(
        //             Duration(milliseconds: 2000), 
        //             onTimeout: () {
        //               print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Device connection timeout');
        //               _state.add(DeviceState.notFound);
        //               timer.cancel();
        //             }
        //           )
        //           .catchError((err) {
        //             print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}]Error connecting device');
        //               _state.add(DeviceState.notFound);
        //               timer.cancel();
        //           });
  //     }
  //   );
  // }

  // bool _isConnectionLost(DeviceState newState) {
  //   if (
  //     _state.value == DeviceState.connected 
  //     && newState == DeviceState.disconnected
  //   )
  //     return true;
  //   else
  //     return false;
  // }

  // void _reconnect() {
  //   print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Device has been disconnected, reconnecting...');
  //   _btDevice.connect()
  //     .timeout(
  //       Duration(milliseconds: 2000), 
  //       onTimeout: () {
  //         print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Device connection lost');
  //         _state.add(DeviceState.notFound);
  //       }
  //     )
  //     .catchError((err) {
  //       print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}]Error reconnecting device');
  //     });
  // }

  DeviceState _mapBTStateToDeviceState(BTDeviceState btDeviceState) {
    DeviceState outState;
    switch (btDeviceState) {
      case BTDeviceState.disconnected:
      case BTDeviceState.connecting:
      case BTDeviceState.disconnecting:
        outState = DeviceState.disconnected;
        break;
      case BTDeviceState.connected:
        outState = DeviceState.connected;
        break;
    }
    return outState;
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is Device &&
              runtimeType == other.runtimeType &&
              _id == other._id &&
              _name == other._name &&
              _type == other._type;
  @override
  int get hashCode => hashValues(_id.hashCode, _name.hashCode, _type.hashCode);

}

abstract class TrainerDevice extends Device {
  TrainerDevice(DeviceID id, String name, DeviceType type)
      : super(id, name, type);

}

abstract class HeartRateDevice extends Device{

  HeartRateDevice(DeviceID id, String name, DeviceType type)
      : super(id, name, type);

}

abstract class CadenceDevice extends Device{

  CadenceDevice(DeviceID id, String name, DeviceType type)
      : super(id, name, type);

}

abstract class SpeedDevice extends Device{

  SpeedDevice(DeviceID id, String name, DeviceType type)
      : super(id, name, type);

}

enum DeviceType {
  cadence,
  heartRate,
  speed,
  trainer,
}

enum DeviceState {
  connected,
  disconnected,
  notFound,
}

enum DeviceClass {
  bkoolTrainer,
  standardHeartRate,
}