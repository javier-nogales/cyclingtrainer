import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/db/db_device_factory.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/api/use_cases/bt_device_check_controller.dart';
import 'package:trainerapp/api/use_cases/bt_device_check_use_cases.dart';
import 'package:trainerapp/core/error/several_failure.dart';

import '../bluetooth/mock_blue_device.dart';

class MockDBDeviceFactory extends Mock 
  implements DBDeviceFactory {}

void main() {

  BTDeviceCheckUseCases useCases;
  BTDevice btDevice;
  DBDevice dbDevice;
  MockDBDeviceFactory mockDBDeviceFactory;
  group('BTDevice info use cases', () {

    setUp((){
      mockDBDeviceFactory = MockDBDeviceFactory();
      useCases = BTDeviceCheckController(mockDBDeviceFactory);
      btDevice = MockBlueDevice();
      dbDevice = DBDevice("fakeId", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
    });

    test('Return checked DBDevice', () async {

      when(mockDBDeviceFactory.fromBTDevice(btDevice))
        .thenAnswer((_) async => dbDevice);

      final result = await useCases.checkDevice(btDevice);

      result.fold(
        (failure) => throw AssertionError(), 
        (device) => expect(dbDevice, dbDevice)
      );

    });

    test('Return Failure', () async {

      when(mockDBDeviceFactory.fromBTDevice(btDevice))
        .thenAnswer((_) async => throw Error());

      final result = await useCases.checkDevice(btDevice);

      result.fold(
        (failure) => expect(failure, SeveralFailure()), 
        (device) => throw AssertionError()
      );


    });

  });

}