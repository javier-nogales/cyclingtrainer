

import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/identifiers.dart';
import 'package:trainerapp/api/db/db_provider.dart';

class MockSQFLiteProvider implements DBProvider {

  bool _throwFailure = false;
  set throwFailure(bool throwFailure) => _throwFailure = throwFailure;
  Failure _failure;
  set failure(Failure failure) => _failure = failure;

  MockSQFLiteProvider();

  @override
  Future<DBDevice> getHeartRateDevice() async {
    DBDevice dbDevice = DBDevice("fakeID", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
    return dbDevice;
  }

  @override
  Future<DBDevice> getTrainerDevice() async {
    DBDevice dbDevice = DBDevice("fakeID", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
    return dbDevice;
  }

  @override
  Future<DBDevice> createDevice(DBDevice dbDevice) async {
    if (_throwFailure && _failure != null)
      throw _failure;
    return dbDevice;
  }

  @override
  Future<void> deleteDevice(DeviceID id) {
    if (_throwFailure && _failure != null)
      throw _failure;
  }

  @override
  Future<List<DBDevice>> getAllDevices() {
    // TODO: implement getAllDevices
    return null;
  }
}