
import 'package:trainerapp/api/bluetooth/bt_device.dart';

// interface
abstract class BluetoothProvider {

  Future<BTDevice> findDeviceById(String deviceId);

  Stream<List<BTDevice>> fetchAllDevices();

  Stream<bool> isScanning();

}