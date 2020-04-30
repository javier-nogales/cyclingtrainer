
import 'package:trainerapp/api/db/sqflite_driver.dart';
import 'package:trainerapp/api/device/device_package.dart';

import 'db_device.dart';

class SQFLiteCRUD {

  final _driver = SQFLiteDriver.driver;

  static final SQFLiteCRUD crudService = SQFLiteCRUD._();
  SQFLiteCRUD._();

  // Create
  Future<int> createDevice(DBDevice device) async {
    final db = await _driver.database;
    final result = db.insert('devices', device.toJson());
    return result;
  }

  Future<DBDevice> getDeviceByType(DeviceType type) async {
    final db = await _driver.database;
    final result = await db.query('devices', where: 'type = ?', whereArgs: [type.toString()]);
    return result.isNotEmpty ? DBDevice.fromJson(result.first) : null;
  }


}