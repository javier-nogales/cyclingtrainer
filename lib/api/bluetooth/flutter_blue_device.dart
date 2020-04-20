
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

  @override
  Future<List<ServiceUUID>> fetchServiceUUIDs() async {
    if (await this.btState.last == BTDeviceState.disconnected) {
      await _device.connect();
    }

    List<BluetoothService> services = await _device.discoverServices();

    return services.map((service) => ServiceUUID(service.uuid.toString()))
                   .toList();
  }

////////////////////////////////////////////////////////////
// private methods
////////////////////////////////////////////////////////////
  BTDeviceState _transformDeviceState(BluetoothDeviceState bluetoothDeviceState) {
    switch(bluetoothDeviceState) {
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