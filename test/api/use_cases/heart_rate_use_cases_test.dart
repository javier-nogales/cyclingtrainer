

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/device/device_repository.dart';
import 'package:trainerapp/api/use_cases/heart_rate_device_controller.dart';
import 'package:trainerapp/api/use_cases/heart_rate_device_uses_cases.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';

import '../bluetooth/mock_blue_device.dart';

class MockHeartRateDeviceRepository extends Mock
    implements HeartRateDeviceRepository {}

void main() {

  Device device;
  DBDevice dbDevice;
  MockBlueDevice btDevice;
  HeartRateDeviceUseCases useCases;
  DeviceRepository<HeartRateDevice> repository;

  setUp(() {

    dbDevice = DBDevice("fakeID", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
    btDevice = MockBlueDevice();
    device = HeartRateDeviceFactory().from(dbDevice);
    repository = MockHeartRateDeviceRepository();
    useCases = HeartRateDeviceController(repository);

  });

  test('Should get heart rate device state', () async {

    when(repository.getDevice())
        .thenAnswer((_) async => device);
    btDevice.addState(BTDeviceState.connected);

    final result = await useCases.getHeartRateDeviceState();

    result.fold(
            (failure) => throw AssertionError(),
            (state) => expect(state, emitsAnyOf(DeviceState.values)));

  });

  test('Should get failure', () async {

    when(repository.getDevice())
        .thenThrow(SeveralFailure());
    btDevice.addState(BTDeviceState.connected);

    final result = await useCases.getHeartRateDeviceState();

    result.fold(
            (failure) => expect(failure, isA<Failure>()),
            (state) => throw AssertionError());

  });

}