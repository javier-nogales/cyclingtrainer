

import 'dart:async';

import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/device/identifiers.dart';

class MockBlueDevice implements BTDevice {

  @override
  DeviceID get btId => _id;

  @override
  String get btName => _name;

  @override
  Stream<BTDeviceState> get btState => _streamController.stream;

//==============================================================================
//
//==============================================================================
  StreamController<BTDeviceState> _streamController = StreamController<BTDeviceState>.broadcast();
  DeviceID _id;
  String _name;
//==============================================================================
//
//==============================================================================
  addState(BTDeviceState state) async {
    return _streamController.sink.add(state);
  }
  addId(String id) {
    _id = DeviceID(id);
  }
  addName(String name) {
    _name = name;
  }

  closeStateBTStream() {
    _streamController.close();
  }

}