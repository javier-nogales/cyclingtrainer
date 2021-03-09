

import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';

import '../../api/device/mock_device.dart';

void main() {

  group('DeviceLinkingEvent', () {

    group('DeviceLinkStarted', ()  {
      test('toString returns correct value', () {
        DBDevice dbDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
        expect(DeviceLinkStarted(dbDevice).toString(), 'DeviceLinkStarted:[$dbDevice]');
      });
    });

    group('DeviceLinkSucceeded', () {
      test('toString return correct value', () {
        DBDevice dbDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
        expect(DeviceLinkSucceeded(dbDevice).toString(), 'DeviceLinkSucceeded:[$dbDevice]');
      });
    });

    group('DeviceLinkFailed', () {
      test('to String returns correct value', () {
        expect(DeviceLinkFailed().toString(), 'DeviceLinkFailed');
      });
    });

    group('DeviceUnlinkStarted', ()  {
      test('toString returns correct value', () {
        MockDevice mockDevice = MockHeartRateDevice();
        expect(DeviceUnlinkStarted(mockDevice.device).toString(), 'DeviceUnlinkStarted:[${mockDevice.device}]');
      });
    });

    group('DeviceInlinkSucceeded', () {
      test('toString return correct value', () {
        DBDevice dbDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
        expect(DeviceUnlinkSucceeded().toString(), 'DeviceUnlinkSucceeded');
      });
    });

    group('DeviceUnlinkFailed', () {
      test('to String returns correct value', () {
        expect(DeviceUnlinkFailed().toString(), 'DeviceUnlinkFailed');
      });
    });

});

}