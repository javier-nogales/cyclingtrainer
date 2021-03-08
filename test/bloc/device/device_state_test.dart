


import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/device/device_package.dart';
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

  group('HeartRateDeviceStateState', () {

    group('InitialDeviceState', () {
      test('toString returns correct value', () {
        expect(
            DeviceInitial().toString(),
            'DeviceInitial'
        );
      });
    });

    group('HeartRateDeviceStateLoadInProgress', () {
      test('toString returns correct value', () {
        expect(
            DeviceLoadInProgress().toString(),
            'DeviceLoadInProgress'
        );
      });
    });

    group('HeartRateDeviceStateUpdateSuccess', () {
      test('toString returns correct value', () {
        expect(
            DeviceUpdateSuccess(device).toString(),
            'DeviceUpdateSuccess:[$device]'
        );
      });
    });

    group('HeartRateDeviceStateFailure', () {
      test('toString returns correct value', () {
        expect(
            DeviceFailure().toString(),
            'DeviceFailure'
        );
      });
    });

  });

}