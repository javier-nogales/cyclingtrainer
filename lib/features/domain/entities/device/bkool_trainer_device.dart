

import 'package:trainerapp/features/domain/entities/identifiers.dart';

import 'device_package.dart';

class BkoolTrainerDevice extends TrainerDevice {

  BkoolTrainerDevice(String id, String name, DeviceType type)
      : super(DeviceID(id), name, type);

}