
import 'package:trainerapp/api/db/sqflite_driver.dart';

import 'db_device.dart';

class SQFLiteCRUD {

  final _driver = SQFLiteDriver.driver;

  static final SQFLiteCRUD crudService = SQFLiteCRUD._();
  SQFLiteCRUD._();

  // Create
  Future<int> createDevice(DBDevice device) async {
    final db = await _driver.database;
    final result = db.insert('Devices', device.toJson());
    return result;
  }


}