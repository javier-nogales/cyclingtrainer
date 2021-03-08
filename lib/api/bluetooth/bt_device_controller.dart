
import 'package:trainerapp/api/device/identifiers.dart';

import 'bluetooth_provider.dart';
import 'bt_device.dart';

class BTDeviceController {

  final BluetoothProvider _bluetoothProvider;
  BTDevice _btDevice;

  BTDeviceController(this._bluetoothProvider);

  BTDevice get btDevice => _btDevice;

  Stream<BTDeviceState> get btState => _btDevice.btState;


  Future<BTDevice> load(DeviceID id) async {
    _btDevice = await _bluetoothProvider.findDeviceById(id.toString());
    if (_btDevice != null) {
      _btDevice.ensureConnection(
        onConnect: () {
          print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] ** Device is connected');
        },
        onConnectionLost: () {
          print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] ** Device Connection lost');
        }
      );
    } else {
      
    }
  }

}