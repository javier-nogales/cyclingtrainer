
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/const_service_uuid.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/device/identifiers.dart';
import 'package:trainerapp/core/error/exceptions.dart';

import 'db_device.dart';

abstract class DBDeviceFactory {
  Future<DBDevice> fromBTDevice(BTDevice btDevice);
}

class DefaultDBDeviceFactory implements DBDeviceFactory {

  Future<DBDevice> fromBTDevice(BTDevice btDevice) async {

    List<ServiceUUID> serviceUUIDs = await btDevice.fetchServiceUUIDs();

    DeviceType type;
    DeviceClass deviceClass;
    if (serviceUUIDs.contains(org_bluetooth_service__heart_rate)) {
      type = DeviceType.heartRate;
      deviceClass = DeviceClass.standardHeartRate;
    } else if (serviceUUIDs.contains(bkool_custom_service__cycling_power)) {
      type = DeviceType.trainer;
      deviceClass = DeviceClass.bkoolTrainer;
    } else {
      throw UnsupportedDeviceException();
    }

    return DBDevice(btDevice.btId.toString(), btDevice.btName, type, deviceClass);
  }
  
}