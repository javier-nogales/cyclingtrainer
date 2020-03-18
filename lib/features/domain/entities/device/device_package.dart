

import 'dart:async';
import 'dart:ui';

import 'package:trainerapp/features/domain/entities/bluetooth/bluetooth_package.dart';
import 'package:trainerapp/features/domain/entities/database/database_package.dart';

import 'standard_heart_rate_device.dart';

import 'bkool_trainer_device.dart';


abstract class DeviceBase {

  final String _id;
  final String _name;
  final DeviceType _type;

  BTDevice _device;

  // TODO: set state as Stream<DeviceState> from device.
  StreamController<DeviceState> _stateController = StreamController<DeviceState>.broadcast();
  Stream<DeviceState> get state => _stateController.stream;

  DeviceBase(this._id, this._name, this._type) {
    // at this time device is null
    _stateController.add(DeviceState.notFound);
  }

  set btDevice(BTDevice device) {
    _device = device;
    if (device == null) {
      _stateController.add(DeviceState.notFound);
    } else {
//      _device.state.listen((btDeviceState) {
//        _stateController.add(_transformBTStateToDeviceState(btDeviceState));
//      });
    }
  }
  BTDevice get btDevice => this._device;

  DeviceState _transformBTStateToDeviceState(BTDeviceState btDeviceState) {
    DeviceState outState;
    switch (btDeviceState) {
      case BTDeviceState.disconnected:
      case BTDeviceState.connecting:
        outState = DeviceState.disconnected;
        break;
      case BTDeviceState.connected:
      case BTDeviceState.disconnecting:
        outState = DeviceState.connected;
        break;
    }
    return outState;
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is DeviceBase &&
              runtimeType == other.runtimeType &&
              _id == other._id &&
              _name == other._name &&
              _type == other._type;
  @override
  int get hashCode => hashValues(_id.hashCode, _name.hashCode, _type.hashCode);

}

abstract class TrainerDevice extends DeviceBase {

  TrainerDevice(String id, String name, DeviceType type) : super(id, name, type);

  factory TrainerDevice.from(DBDevice dbDevice) {
    TrainerDevice outDevice;
    switch (dbDevice.deviceClass) {
      case DeviceClass.bkoolTrainer:
        outDevice = new BkoolTrainerDevice(dbDevice.id, dbDevice.name, dbDevice.type);
        break;
      default:
      // TODO: throw exception
    }
    return outDevice;
  }

}

abstract class HeartRateDevice extends DeviceBase{

  HeartRateDevice(String id, String name, DeviceType type) : super(id, name, type);

  factory HeartRateDevice.from(DBDevice dbDevice) {
    HeartRateDevice outDevice;
    switch (dbDevice.deviceClass) {
      case DeviceClass.standardHeartRate:
        outDevice = new StandardHeartRateDevice(dbDevice.id, dbDevice.name, dbDevice.type);
        break;
      default:
      // TODO: throw exception
    }
    return outDevice;
  }

}

enum DeviceType {
  cadence,
  heartRate,
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