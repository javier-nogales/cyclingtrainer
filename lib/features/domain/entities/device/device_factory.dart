
import 'package:trainerapp/features/domain/entities/database/database_package.dart';
import 'package:trainerapp/features/domain/entities/device/bkool_trainer_device.dart';
import 'package:trainerapp/features/domain/entities/device/device_package.dart';
import 'package:trainerapp/features/domain/entities/device/standard_heart_rate_device.dart';

abstract class DeviceFactory<T extends Device> {
  T from(DBDevice dbDevice);
}

class TrainerDeviceFactory implements DeviceFactory<TrainerDevice>{
  TrainerDevice from(DBDevice dbDevice) {
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

class HeartRateDeviceFactory implements DeviceFactory<HeartRateDevice> {
  HeartRateDevice from(DBDevice dbDevice) {
    HeartRateDevice outDevice;
    switch (dbDevice.deviceClass) {
      case DeviceClass.standardHeartRate:
        outDevice = new StandardHeartRateDevice(dbDevice.id, dbDevice.name, dbDevice.type);
        break;
      default:
      // TODO: throw exception
    }
    return outDevice;
  }
}