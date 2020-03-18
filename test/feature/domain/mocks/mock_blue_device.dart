

import 'dart:async';

import 'package:trainerapp/features/domain/entities/bt_device.dart';
import 'package:trainerapp/features/domain/entities/bt_device_state.dart';

class MockBlueDevice implements BTDevice {

  StreamController<BTDeviceState> _streamController = StreamController<BTDeviceState>.broadcast();

  @override
  Stream<BTDeviceState> get state => _streamController.stream;

  addState(BTDeviceState state) {
    _streamController.sink.add(state);
  }

}