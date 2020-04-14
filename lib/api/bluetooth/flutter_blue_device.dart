
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/device/identifiers.dart';


class FlutterBlueDevice implements BTDevice {

  final BluetoothDevice _device;

  FlutterBlueDevice(this._device);

  @override
  DeviceID get btId => DeviceID(_device.id.toString());

  @override
  String get btName => _device.name;
  
  @override
  Stream<BTDeviceState> get btState =>
      _device.state.map((BluetoothDeviceState bds) =>
          _transformDeviceState(bds)
      );

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
      default:
      // TODO: throw especific error.
      throw Error();
      break;
    }

  }

}