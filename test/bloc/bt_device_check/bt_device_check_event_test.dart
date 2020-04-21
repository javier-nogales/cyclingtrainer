import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/bloc/bt_device_check/bt_device_check_bloc.dart';

import '../../api/bluetooth/mock_blue_device.dart';

void main() {

  group('BTDeviceCheckEvent', () {

    group('BTDeviceCheckStarted', () {
      BTDevice btDevice = MockBlueDevice()..addId("fakeId")..addName("fakeName");
      test('toString returns correct value', () {
        expect(BTDeviceCheckStarted(btDevice).toString(), 'btDeviceCheckStarted:[$btDevice]');
      });
    });

    group('BTDeviceCheckSucceeded', () {
      DBDevice dbDevice = DBDevice("fakeId", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
      test('toString returns correct value', () {
        expect(
          BTDeviceCheckSucceeded(dbDevice).toString(), 
          'btDeviceCheckSucceeded:[fakeId,fakeName,DeviceType.trainer,DeviceClass.bkoolTrainer]'
        );
      });
    });

    group('BTDeviceCheckFailed', () {
      test('toString returns correct value', () {
        expect(BTDeviceCheckFailed().toString(), 'btDeviceCheckFailed');
      });
    });

  });

}