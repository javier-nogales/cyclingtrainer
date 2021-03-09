

import 'package:trainerapp/api/device/identifiers.dart';

import 'device.dart';

class BkoolTrainerDevice extends TrainerDevice {

  BkoolTrainerDevice(String id, String name, DeviceType type)
      : super(DeviceID(id), name, type);

}