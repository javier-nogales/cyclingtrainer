import 'package:trainerapp/api/bluetooth/bt_device_controller.dart';
import 'package:trainerapp/api/device/identifiers.dart';

import 'device.dart';

class BkoolTrainerDevice extends TrainerDevice {

  BkoolTrainerDevice(String id, String name, DeviceType type, BTDeviceController btDeviceController)
      : super(DeviceID(id), name, type, btDeviceController);

}