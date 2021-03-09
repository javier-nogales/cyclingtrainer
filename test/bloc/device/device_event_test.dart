


import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/bloc/device/device_bloc.dart';

import '../../api/bluetooth/mock_blue_device.dart';

void main() {

  Device device;
  DBDevice dbDevice;
  MockBlueDevice btDevice;
  
  setUp((){
    dbDevice = DBDevice("fakeID", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
    btDevice = MockBlueDevice();
    device = HeartRateDeviceFactory().from(dbDevice); //no matter the type
  });

  group('DeviceEvent', () {

    group('DeviceStarted', () {
      test('toString returns correct value', () {
        expect(
            DeviceStarted().toString(),
            'DeviceStarted'
        );
      });
    });

    group('DeviceUpdated', () {
      test('toString returns correct value', () {
        expect(
            DeviceUpdated(device).toString(),
            'DeviceUpdated:[$device]'
        );
      });
    });

    group('DeviceFailed', () {
      test('toString returns correct value', () {
        expect(
            DeviceFailed().toString(),
            'DeviceFailed'
        );
      });
    });

  });

}