import 'package:trainerapp/api/bluetooth/bt_device.dart';
// import 'package:trainerapp/api/bluetooth/const_service_uuid.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/api/device/identifiers.dart';
import 'package:trainerapp/core/error/exceptions.dart';

import 'db_device.dart';

abstract class DBDeviceFactory {
  Future<DBDevice> fromBTDevice(BTDevice btDevice);
}

class DefaultDBDeviceFactory implements DBDeviceFactory {

  final org_bluetooth_service__heart_rate =  ServiceUUID('180d');
  final org_bluetooth_service__cycling_power = ServiceUUID('1818');
  final bkool_custom_service__cycling_power = ServiceUUID('f03eee01-4910-473c-be46-960948c2f590');

  Future<DBDevice> fromBTDevice(BTDevice btDevice) async {

    List<ServiceUUID> serviceUUIDs = await btDevice.fetchServiceUUIDs();

    DeviceType type;
    DeviceClass deviceClass;
    if (serviceUUIDs.contains(ServiceUUID('0000180d-0000-1000-8000-00805f9b34fb'))) {
      type = DeviceType.heartRate;
      deviceClass = DeviceClass.standardHeartRate;
    } else if (serviceUUIDs.contains(ServiceUUID('f03eee01-4910-473c-be46-960948c2f59c'))) {
      type = DeviceType.trainer;
      deviceClass = DeviceClass.bkoolTrainer;
    } else {
      throw UnsupportedDeviceException();
    }

    return DBDevice(btDevice.btId.toString(), btDevice.btName, type, deviceClass);
  }
  
}