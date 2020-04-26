

import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';

import '../../api/device/mock_device.dart';

void main() {
  
  group('DeviceLinkingState', () {

    group('DeviceLinkinkInitial', () {
      test('toString returns correct value', () {
        expect(DeviceLinkingInitial().toString(), 'DeviceLinkingInitial');
      });
    });

    group('DeviceLinkInProgress', () {
      test('toString returns correct value', () {
        expect(DeviceLinkInProgress().toString(), 'DeviceLinkInProgress');
      });
    });

    group('DeviceLinkSuccess', () {
      test('toString returns correct value', () {
        DBDevice dbDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
        expect(DeviceLinkSuccess(dbDevice).toString(), 'DeviceLinkSuccess:[$dbDevice]');
      });
    });

    group('DeviceUnlinkFailure', () {
      test('toString returns correct value', () {
        expect(DeviceUnlinkFailure().toString(), 'DeviceUnlinkFailure');
      });
    });

    group('DeviceUnlinkInProgress', () {
      test('toString returns correct value', () {
        expect(DeviceUnlinkInProgress().toString(), 'DeviceUnlinkInProgress');
      });
    });

    group('DeviceUnlinkSuccess', () {
      test('toString returns correct value', () {
        expect(DeviceUnlinkSuccess().toString(), 'DeviceUnlinkSuccess');
      });
    });

    group('DeviceLinkFailure', () {
      test('toString returns correct value', () {
        expect(DeviceLinkFailure().toString(), 'DeviceLinkFailure');
      });
    });

  });

}