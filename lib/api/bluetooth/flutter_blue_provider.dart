
import 'package:rxdart/rxdart.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/bluetooth/flutter_blue_device.dart';

class FlutterBlueProvider implements BluetoothProvider {

  final _flutterBlue = FlutterBlue.instance;
  final _btDevicesStream = BehaviorSubject<List<BTDevice>>();

  FlutterBlueProvider() {
    var subscription = _flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

//    _flutterBlue.scanResults.listen((scanResults) {
//      print('Listen results');
//      List<BTDevice> outList = [];
//      print('2');
//      scanResults.forEach((result) {
//        print('single result = ${result.device.id}');
//        final btDevice = FlutterBlueDevice(result.device);
//        outList.add(btDevice);
//      });
//      _btDevicesStream.add(outList);
//    });
  }

  @override
  Stream<List<BTDevice>> fetchAllDevices() {
    _flutterBlue.startScan(timeout: Duration(seconds: 3));
    return _btDevicesStream;
//    Stream<List<BTDevice>> outList = _flutterBlue.scanResults.asyncMap(
//            (List<ScanResult> results) {
//              return results.map((r) => FlutterBlueDevice(r.device)).toList();
//            }
//    );
//    return outList;
  }

  @override
  Future<BTDevice> findDeviceById(String deviceId) {
    // TODO: implement findDeviceById
    return null;
  }



}