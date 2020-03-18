
import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/features/domain/entities/bluetooth/bluetooth_package.dart';



class FlutterBlueDevice implements BTDevice {

  final BluetoothDevice _device;

  FlutterBlueDevice(this._device);

// TODO: remove if is not valid code
//  Stream<BTDeviceState> get state async* {
//    await for (BluetoothDeviceState bds in _device.state) {
//      yield _transformDeviceState(bds);
//    }
//  }
  @override
  Stream<BTDeviceState> get state =>
      _device.state.map((BluetoothDeviceState bds) => _transformDeviceState(bds));

  BTDeviceState _transformDeviceState(BluetoothDeviceState bds) {
    switch(bds) {
      case BluetoothDeviceState.disconnected:
        return BTDeviceState.disconnected;
        break;
      case BluetoothDeviceState.connecting:
        return BTDeviceState.connecting;
        break;
      case BluetoothDeviceState.connected:
        return BTDeviceState.connected;
        break;
      case BluetoothDeviceState.disconnecting:
        return BTDeviceState.disconnecting;
        break;
    }

  }



}