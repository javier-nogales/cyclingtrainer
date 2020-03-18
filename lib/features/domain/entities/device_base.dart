
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainerapp/features/domain/entities/bt_device.dart';
import 'package:trainerapp/features/domain/entities/bt_device_state.dart';
import 'package:trainerapp/features/domain/entities/device_state.dart';
import 'package:trainerapp/features/domain/entities/device_type.dart';

abstract class DeviceBase {

//==============================================================================
// Fields
//==============================================================================
  final String _id;
  final String _name;
  final DeviceType _type;

  BTDevice _device;

  //final subject = BehaviorSubject<int>();

  // TODO: set state as Stream<DeviceState> from device.
  StreamController<DeviceState> _stateController = StreamController<DeviceState>.broadcast();
  Stream<DeviceState> get state => _stateController.stream;

//==============================================================================
// Constructor
//==============================================================================
  DeviceBase(this._id, this._name, this._type) {
    // at this time device is null
    _stateController.add(DeviceState.notFound);
  }

//==============================================================================
// Getters & Setters
//==============================================================================
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

//==============================================================================
// Private methods
//==============================================================================
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
//==============================================================================
// Equals
//==============================================================================
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