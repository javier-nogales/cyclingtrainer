
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/api/device/identifiers.dart';

import '../bluetooth/mock_blue_device.dart';

abstract class MockDevice<T extends Device> {

  MockBlueDevice mockBTDevice;
  T device;
  BTDevice btDevice;

  MockDevice() {
    mockBTDevice = MockBlueDevice();
    btDevice = mockBTDevice;

  }

  Future<T> getDevice() async => device;

  DeviceID get id => device.id;

  String get name => device.name;

  Stream<DeviceState> get state => device.state;

  DeviceType get type => device.type;

  addBTState(BTDeviceState state) async {
    return mockBTDevice.addState(state);
  }

}

class MockTrainerDevice extends MockDevice<TrainerDevice>{

  MockTrainerDevice() {
    DBDevice dbDevice = DBDevice("fakeID", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
    device = TrainerDeviceFactory().from(dbDevice);
    // device.btDevice = btDevice;
  }

}

class MockHeartRateDevice extends MockDevice<HeartRateDevice>{

  MockHeartRateDevice() {
    DBDevice dbDevice = DBDevice("fakeID", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
    device = HeartRateDeviceFactory().from(dbDevice);
    // device.btDevice = btDevice;
  }

}