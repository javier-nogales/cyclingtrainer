
import 'package:trainerapp/api/db/sqflite_driver.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/device/identifiers.dart';

import 'db_device.dart';

class SQFLiteCRUD {

  final _driver = SQFLiteDriver.driver;

  static final SQFLiteCRUD crudService = SQFLiteCRUD._();
  SQFLiteCRUD._();

  // Create
  Future<int> createDevice(DBDevice device) async {
    final db = await _driver.database;
    final result = await db.insert('devices', device.toJson());
    return result;
  }

  Future<int> deleteDevice(DeviceID deviceId) async {
    final db = await _driver.database;
    final result = await db.delete('devices', where: 'id = ?', whereArgs: [deviceId.toString()]);
    return result;
  }

  Future<DBDevice> getDeviceByType(DeviceType type) async {
    final db = await _driver.database;
    final result = await db.query('devices', where: 'type = ?', whereArgs: [type.toString()]);
    return result.isNotEmpty ? DBDevice.fromJson(result.first) : null;
  }

  Future<List<DBDevice>> readAll() async {
    final db = await _driver.database;
    final results = await db.query('devices');
    final List<DBDevice> devices = results.map((result) => DBDevice.fromJson(result)).toList();
    return devices;
  }


}