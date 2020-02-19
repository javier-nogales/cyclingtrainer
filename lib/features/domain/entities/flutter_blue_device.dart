
import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/features/domain/entities/device.dart';

class FlutterBlueDevice extends Device {

  final BluetoothDevice _device;

  FlutterBlueDevice(this._device);

  @override
  Future<void> connect() {
    return _device.connect();
  }

  @override
  Future<dynamic> disconnect() {
    return _device.disconnect();
  }

}