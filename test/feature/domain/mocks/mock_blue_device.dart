

import 'dart:async';

import 'package:trainerapp/features/domain/entities/bluetooth/bluetooth_package.dart';
import 'package:trainerapp/features/domain/entities/identifiers.dart';

class MockBlueDevice implements BTDevice {

  @override
  DeviceID get btId => null;

  @override
  String get btName => null;

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
  addState(BTDeviceState state) {
    _streamController.sink.add(state);
  }
  addId(String id) {
    _id = DeviceID(id);
  }
  addName(String name) {
    _name = name;
  }

}