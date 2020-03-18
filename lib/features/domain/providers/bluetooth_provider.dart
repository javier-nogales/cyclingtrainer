


// interface
import 'package:trainerapp/features/domain/entities/bluetooth/bluetooth_package.dart';

abstract class BluetoothProvider {

  Future<BTDevice> findDeviceById(String deviceId);

}