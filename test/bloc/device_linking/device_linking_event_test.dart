

import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';

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
        DBDevice dbDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
        expect(DeviceUnlinkStarted(dbDevice).toString(), 'DeviceUnlinkStarted:[$dbDevice]');
      });
    });

    group('DeviceInlinkSucceeded', () {
      test('toString return correct value', () {
        DBDevice dbDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
        expect(DeviceUnlinkSucceeded(dbDevice).toString(), 'DeviceUnlinkSucceeded:[$dbDevice]');
      });
    });

    group('DeviceUnlinkFailed', () {
      test('to String returns correct value', () {
        expect(DeviceUnlinkFailed().toString(), 'DeviceUnlinkFailed');
      });
    });

});

}