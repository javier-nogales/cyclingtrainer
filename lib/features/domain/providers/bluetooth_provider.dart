


// interface
import 'package:trainerapp/features/domain/entities/bt_device.dart';

abstract class BluetoothProvider {

  Future<BTDevice> findDeviceById(String deviceId);

}