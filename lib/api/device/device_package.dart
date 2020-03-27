

import 'dart:async';
import 'dart:ui';
import 'package:rxdart/rxdart.dart';

import 'package:trainerapp/api/bluetooth/bt_device.dart';

import 'identifiers.dart';

/// ----------------------------------------------------------------------------
///
/// ----------------------------------------------------------------------------
abstract class Device {

  final DeviceID _id;
  final String _name;
  final DeviceType _type;
  final _state = BehaviorSubject<DeviceState>();

  BTDevice _btDevice;

  Device(this._id, this._name, this._type) {
    // at this time device is null
    _state.add(DeviceState.notFound);
  }

  DeviceID get id => _id;
  String get name => _name;
  DeviceType get type => _type;
  Stream<DeviceState> get state => _state.stream;

  set btDevice(BTDevice device) {
    _btDevice = device;
    if (device == null) {
      _state.add(DeviceState.notFound);
    } else {
      _btDevice.btState.listen((btDeviceState) {
        _state.add(_transformBTStateToDeviceState(btDeviceState));
      });
    }
  }
  BTDevice get btDevice => this._btDevice;

  DeviceState _transformBTStateToDeviceState(BTDeviceState btDeviceState) {
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

/// ----------------------------------------------------------------------------
///
/// ----------------------------------------------------------------------------
abstract class TrainerDevice extends Device {

  TrainerDevice(DeviceID id, String name, DeviceType type)
      : super(id, name, type);

}

/// ----------------------------------------------------------------------------
///
/// ----------------------------------------------------------------------------
abstract class HeartRateDevice extends Device{

  HeartRateDevice(DeviceID id, String name, DeviceType type)
      : super(id, name, type);

}



/// ----------------------------------------------------------------------------
///
/// ----------------------------------------------------------------------------
enum DeviceType {
  cadence,
  heartRate,
  trainer,
}
/// ----------------------------------------------------------------------------
///
/// ----------------------------------------------------------------------------
enum DeviceState {
  connected,
  disconnected,
  notFound,
}
/// ----------------------------------------------------------------------------
///
/// ----------------------------------------------------------------------------
enum DeviceClass {
  bkoolTrainer,
  standardHeartRate,
}