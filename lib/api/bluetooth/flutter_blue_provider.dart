
import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/bluetooth/flutter_blue_device.dart';

class FlutterBlueProvider implements BluetoothProvider {

  final _flutterBlue = FlutterBlue.instance;
  
  FlutterBlueProvider();

  @override
  Stream<List<BTDevice>> fetchAllDevices() {
    _flutterBlue.startScan(timeout: Duration(seconds: 3));
    //return _btDevicesStream;
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

  @override
  Stream<bool> isScanning() {
    return _flutterBlue.isScanning;
  }

}