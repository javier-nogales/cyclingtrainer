
import 'package:equatable/equatable.dart';
import 'package:trainerapp/features/domain/entities/bkool_trainer_device.dart';
import 'package:trainerapp/features/domain/entities/db_device.dart';
import 'package:trainerapp/features/domain/entities/device_base.dart';
import 'package:trainerapp/features/domain/entities/device_class.dart';
import 'package:trainerapp/features/domain/entities/device_type.dart';

abstract class TrainerDevice extends DeviceBase {

  TrainerDevice(String id, String name, DeviceType type) : super(id, name, type);

  factory TrainerDevice.from(DBDevice dbDevice) {
    TrainerDevice outDevice;
    switch (dbDevice.deviceClass) {
      case DeviceClass.bkoolTrainer:
        outDevice = new BkoolTrainerDevice(dbDevice.id, dbDevice.name, dbDevice.type);
        break;
      default:
      // TODO: throw exception
    }
    return outDevice;
  }

}