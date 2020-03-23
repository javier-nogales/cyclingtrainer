
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/features/domain/controllers/trainer_device_controller.dart';
import 'package:trainerapp/features/domain/entities/bluetooth/bluetooth_package.dart';
import 'package:trainerapp/features/domain/entities/database/database_package.dart';
import 'package:trainerapp/features/domain/entities/device/device_factory.dart';
import 'package:trainerapp/features/domain/entities/device/device_package.dart';
import 'package:trainerapp/features/domain/repositories/device_repository.dart';
import 'package:trainerapp/features/domain/usecases/trainer_device_usecases.dart';

import '../mocks/mock_blue_device.dart';

class MockTrainerDeviceRepository extends Mock
  implements TrainerDeviceRepository {}

void main (){

  Device device;
  DBDevice dbDevice;
  MockBlueDevice btDevice;
  TrainerDeviceUseCases useCases;
  DeviceRepository<TrainerDevice> repository;

  setUp((){

    dbDevice = DBDevice("fakeID", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
    btDevice = MockBlueDevice();
    device = TrainerDeviceFactory().from(dbDevice);
    repository = MockTrainerDeviceRepository();
    useCases = TrainerDeviceController(repository);

  });

  test('Should get trainer device state', () async {

    when(repository.getDevice())
        .thenAnswer((_) async => device);
    btDevice.addState(BTDeviceState.connected);

    final result = await useCases.getTrainerDeviceState();

    result.fold(
            (failure) => throw AssertionError(),
            (state) => expect(state, emitsAnyOf(DeviceState.values)));

  });

  test('Should get failure', () async {

    SeveralFailure f = SeveralFailure();

    when(repository.getDevice())
        .thenAnswer((_) async => throw SeveralFailure());
    btDevice.addState(BTDeviceState.connected);

    final result = await useCases.getTrainerDeviceState();

    result.fold(
            (failure) => expect(failure, isA<Failure>()),
            (state) => throw AssertionError());

  });

}