
import 'package:trainerapp/features/domain/entities/device_base.dart';
import 'package:trainerapp/features/domain/entities/device_type.dart';
import 'package:trainerapp/features/domain/entities/standard_heart_rate_device.dart';
import 'db_device.dart';
import 'device_class.dart';

abstract class HeartRateDevice extends DeviceBase{
  
  HeartRateDevice(String id, String name, DeviceType type) : super(id, name, type);

  factory HeartRateDevice.from(DBDevice dbDevice) {
    HeartRateDevice outDevice;
    switch (dbDevice.deviceClass) {
      case DeviceClass.standardHeartRate:
        outDevice =
        new StandardHeartRateDevice(dbDevice.id, dbDevice.name, dbDevice.type);
        break;
      default:
      // TODO: throw exception
    }
    return outDevice;
  }

}
