
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/identifiers.dart';
import 'package:trainerapp/api/db/db_provider.dart';

class SQFLiteProvider implements DBProvider {

  @override
  Future<DBDevice> getHeartRateDevice() async {
    // TODO: implement getHeartRateDevice
    return null;
  }

  @override
  Future<DBDevice> getTrainerDevice() async {
    // TODO: implement getTrainerDevice
    return null;
  }

  @override
  Future<DBDevice> createDevice(DBDevice dbDevice) async {
    // TODO: implement linkDevice
    return null;
  }

  @override
  Future<void> deleteDevice(DeviceID id) {
    // TODO: implement deleteDevice
    return null;
  }

}