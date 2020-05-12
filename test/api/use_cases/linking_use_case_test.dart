
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:trainerapp/api/device/device_repository.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/api/use_cases/linking_controller.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/db/db_provider.dart';
import 'package:trainerapp/api/use_cases/linking_use_case.dart';

import '../db/mock_sqflite_provider.dart';

class MockHeartRateDeviceRepository extends Mock
  implements HeartRateDeviceRepository {}

class MockTrainerDeviceRepository extends Mock
  implements TrainerDeviceRepository {}

main() {

  DBProvider provider;
  MockHeartRateDeviceRepository mockHeartRateDeviceRepository;
  MockTrainerDeviceRepository mockTrainerDeviceRepository;
  MockSQFLiteProvider mockSQFLiteProvider;
  LinkingUseCases useCase;

  setUp(() {
    mockSQFLiteProvider = MockSQFLiteProvider();
    provider = mockSQFLiteProvider;
    useCase = LinkingController(provider,
                                mockTrainerDeviceRepository,
                                mockHeartRateDeviceRepository,);
  });

  group('Linking UseCases tests', () {

    DBDevice dbDevice;

    setUp(() {
      dbDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
    });

    test('linkDevice Should return linked device', () async {

      mockSQFLiteProvider.throwFailure = false;

      final result = await useCase.linkDevice(dbDevice);

      result.fold(
              (failure) => throw AssertionError(),
              (dbDevice) => expect(dbDevice, isA<DBDevice>())
      );

    });

    test('linkDevice Should return failure', () async {

      mockSQFLiteProvider.throwFailure = true;
      mockSQFLiteProvider.failure = SeveralFailure();

      final result = await useCase.linkDevice(dbDevice);

      result.fold(
              (failure) => expect(failure, isA<SeveralFailure>()),
              (dbDevice) => throw AssertionError()
      );

    });

  });

  group('Unlink device tests', () {

    DBDevice dbDevice;
    Device device;
    setUp(() {
      dbDevice = DBDevice("fakeID", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
      device = TrainerDeviceFactory().from(dbDevice);
    });

    test('Unlink device no return failure', () async {

      mockSQFLiteProvider.throwFailure = false;

      final result = await useCase.unlinkDevice(device);
      
      result.fold(
              (failure) => throw AssertionError(),
              (_) => {}
      );

    });

    test('Unlink device return failure', () async {

      mockSQFLiteProvider.throwFailure = true;
      mockSQFLiteProvider.failure = SeveralFailure();

      final result = await useCase.unlinkDevice(device);

      result.fold(
              (failure) => expect(failure, isA<Failure>()),
              (_) => throw AssertionError()
      );

    });

  });



}