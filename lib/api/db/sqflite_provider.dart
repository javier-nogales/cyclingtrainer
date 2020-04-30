import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/db/sqflite_crud.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/device/identifiers.dart';
import 'package:trainerapp/api/db/db_provider.dart';
import 'package:trainerapp/core/error/exceptions.dart';

class SQFLiteProvider implements DBProvider {

  final _crudService = SQFLiteCRUD.crudService;

  @override
  Future<DBDevice> createDevice(DBDevice dbDevice) async {
    final result = await _crudService.createDevice(dbDevice);
    if (result == 1) {
      return dbDevice;
    } else {
      throw PersistenceException();
    }
      
  }

  @override
  Future<void> deleteDevice(DeviceID id) {
    // TODO: implement deleteDevice
    return null;
  }

  @override
  Future<DBDevice> getHeartRateDevice() {
    return _crudService.getDeviceByType(DeviceType.heartRate);
  }

  @override
  Future<DBDevice> getTrainerDevice() {
    return _crudService.getDeviceByType(DeviceType.trainer);
  }



}