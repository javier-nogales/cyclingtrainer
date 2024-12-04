

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

  final BTDeviceController _btDeviceController; // BTDeviceController(sl<BluetoothProvider>());

  Device(this._id, this._name, this._type, this._btDeviceController);

  Future<void> initBluetooth() async => await _btDeviceController.load(_id);


  DeviceID get id => _id;
  String get name => _name;
  DeviceType get type => _type;

  Stream<DeviceState> get state => _btDeviceController.btState.map((btState) => _mapBTStateToDeviceState(btState));


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
  TrainerDevice(DeviceID id, String name, DeviceType type, BTDeviceController btDeviceController)
      : super(id, name, type, btDeviceController);

}

abstract class HeartRateDevice extends Device{

  HeartRateDevice(DeviceID id, String name, DeviceType type, BTDeviceController btDeviceController)
      : super(id, name, type, btDeviceController);

}

abstract class CadenceDevice extends Device{

  CadenceDevice(DeviceID id, String name, DeviceType type, BTDeviceController btDeviceController)
      : super(id, name, type, btDeviceController);

}

abstract class SpeedDevice extends Device{

  SpeedDevice(DeviceID id, String name, DeviceType type, BTDeviceController btDeviceController)
      : super(id, name, type, btDeviceController);

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