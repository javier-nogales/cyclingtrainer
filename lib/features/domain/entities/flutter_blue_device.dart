
import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/features/domain/entities/bt_device.dart';

class FlutterBlueDevice implements BTDevice {

  final BluetoothDevice _device;

  FlutterBlueDevice(this._device);

}