


import 'package:trainerapp/features/domain/entities/default_trainer_device.dart';
import 'package:trainerapp/features/domain/entities/trainer_device_type.dart';

abstract class TrainerDevice {

  // TrainerDevice._();

  factory TrainerDevice.fromType(TrainerDeviceType type) {
    switch (type) {
      case TrainerDeviceType.bkool:
        return new DefaultTrainerDevice();   
        break;
      default:
      // TODO: throw exception
    }
  }

}