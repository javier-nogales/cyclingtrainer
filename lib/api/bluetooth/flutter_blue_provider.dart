import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/bluetooth/flutter_blue_device.dart';
import 'package:trainerapp/core/utils/async_utils.dart';

class FlutterBlueProvider implements BluetoothProvider {

  final _flutterBlue = FlutterBlue.instance;
    
  List<ScanResult> _lastResults;
  bool _isScanning = false;

  @override
  Stream<bool> isScanning() {
    return _flutterBlue.isScanning;
  }

  @override
  Stream<List<BTDevice>> fetchAllDevices() {
    if (!_isScanning)
      _updateResults();
    Stream<List<BTDevice>> outList = _flutterBlue.scanResults.asyncMap(
           (List<ScanResult> results) {
             return results.map((r) => FlutterBlueDevice(r.device)).toList();
           }
   );
   return outList;
  }

  @override
  Future<BTDevice> findDeviceById(String deviceId) async {
    List<ScanResult> results = await _getUpdatedResults();
    BTDevice btDevice;
    if (results.isNotEmpty) {
      final ScanResult result = results.firstWhere((result) => result.device.id.toString() == deviceId, orElse: () => null);
      if (result != null) {
        final BluetoothDevice bluetoothDevice = result.device;
        btDevice = FlutterBlueDevice(bluetoothDevice);
      }
    }
    return btDevice;
  }



  Future<List<ScanResult>> _getUpdatedResults() async {
    if (!_isScanning)
      await _updateResults();
    else
      await waitWhile(() => _isScanning);
    return _lastResults;
  }
  Future<void> _updateResults() async {
    _isScanning = true;
    _lastResults = await _flutterBlue.startScan(timeout: Duration(seconds: 3));
    _isScanning = false;
  }

}