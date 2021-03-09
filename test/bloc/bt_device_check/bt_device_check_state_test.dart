import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/bloc/bt_device_check/bt_device_check_bloc.dart';

void main() {

  group('BTDeviceCheckState', () {

    group('InitialBTDeviceCheckState', () {
      test('toString returns correct value', () {
        expect(BTDeviceCheckInitial().toString(), 'btDeviceCheckInitial');
      });
    });

    group('BTDeviceCheckInProgress', () {
      test('toString returns correct value', () {
        expect(BTDeviceCheckInProgress().toString(), 'btDeviceCheckInProgress');
      });
    });

    group('BTDeviceCheckSuccess', () {
      DBDevice dbDevice = DBDevice("fakeId", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
      test('toString returns correct value', () {
        expect(BTDeviceCheckSuccess(dbDevice).toString(), 'btDeviceCheckSuccess:[$dbDevice]');
      });
    });

    group('BTDeviceCkechFailure', () {
      test('toString returns correct value', () {
        expect(BTDeviceCheckFailure().toString(), 'btDeviceCheckFailure');
      });
    });
    
  });

}