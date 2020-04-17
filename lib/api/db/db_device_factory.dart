
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/device/device_package.dart';

import 'db_device.dart';

abstract class DBDeviceFactory {
  Future<DBDevice> fromBTDevice(BTDevice btDevice);
}

// class DefaultDBDeviceFactory implements DBDeviceFactory {

//   Future<DBDevice> fromBTDevice(BTDevice btDevice) async {

//     return null;
//   }
  
// }