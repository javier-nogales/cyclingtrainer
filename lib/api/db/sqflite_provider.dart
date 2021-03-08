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
    final result = await _crudService.createDevice(dbDevice); // return inserted id
    if (result > 0) {
      return dbDevice;
    } else {
      throw PersistenceException();
    }
      
  }

  @override
  Future<void> deleteDevice(DeviceID id) async {
    final result = await _crudService.deleteDevice(id);
    if (result != 1)
      throw PersistenceException();
  }

  @override
  Future<List<DBDevice>> getAllDevices() {
    return _crudService.readAll();
  }

  @override
  Future<DBDevice> getHeartRateDevice() {
    return _crudService.getDeviceByType(DeviceType.heartRate);
  }

  @override
  Future<DBDevice> getTrainerDevice() {
    return _crudService.getDeviceByType(DeviceType.trainer);
  }

  @override
  Future<DBDevice> getDeviceByType(DeviceType type) {
    return _crudService.getDeviceByType(type);
  }

}