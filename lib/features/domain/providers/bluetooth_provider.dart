


// ionterface
import 'package:trainerapp/features/domain/entities/bt_device.dart';

abstract class BluetoothProvider {

  Future<BTDevice> getDeviceById(String deviceId);

}