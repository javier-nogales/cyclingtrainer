
import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/flutter_blue_device.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';

class FlutterBlueProvider implements BluetoothProvider {

  FlutterBlue _flutterBlue = FlutterBlue.instance;

  @override
  Stream<List<BTDevice>> fetchAllDevices() {
    _flutterBlue.scan(timeout: Duration(seconds: 3));
    Stream<List<BTDevice>> outList = _flutterBlue.scanResults.asyncMap(
            (List<ScanResult> results) {
              return results.map((r) => FlutterBlueDevice(r.device)).toList();
            }
    );
    return outList;
  }

  @override
  Future<BTDevice> findDeviceById(String deviceId) {
    // TODO: implement findDeviceById
    return null;
  }



}