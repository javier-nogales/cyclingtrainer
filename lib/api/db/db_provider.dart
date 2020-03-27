
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/identifiers.dart';

// Interface
abstract class DBProvider {

  Future<DBDevice> getTrainerDevice();

  Future<DBDevice> getHeartRateDevice();

  Future<DBDevice> createDevice(DBDevice dbDevice);

  Future<void> deleteDevice(DeviceID id);

}