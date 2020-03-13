

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/features/domain/entities/default_trainer_device.dart';
import 'package:trainerapp/features/domain/entities/bt_device.dart';
import 'package:trainerapp/features/domain/entities/devide.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/entities/trainer_device_type.dart';
import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/providers/data_provider.dart';
import 'package:trainerapp/features/domain/repositories/trainer_device_repository_impl.dart';

////////////////////////////////////////////////////////////
// Mocks
////////////////////////////////////////////////////////////
class MockBluetoothProvider extends Mock
                         implements BluetoothProvider {}
class MockDataProvider extends Mock
                    implements DataProvider {}
class MockDevice extends Mock   
              implements Device {}

void main() {

  MockBluetoothProvider mockBluetoothProvider;
  MockDataProvider mockDataProvider;
  TrainerDeviceRepositoryImpl repository;

  setUp((){
    mockBluetoothProvider = MockBluetoothProvider();
    mockDataProvider = MockDataProvider();
    repository = TrainerDeviceRepositoryImpl(mockDataProvider, mockBluetoothProvider);
  });

  final TrainerDevice trainerDevice = DefaultTrainerDevice();

  group('Test group when not exists linked Device', () {
    final TrainerDevice trainerDevice = null;
    test('Test there is no device data', () async {
      when(mockDataProvider.getTrainerDevice())
                           .thenAnswer((_) async => trainerDevice);
      final result = await repository.getDevice();
      expect(result, equals(Right(trainerDevice)));
    });
  });

  group('Test group when exists linked device', () {
    final TrainerDevice trainerDevice = TrainerDevice.fromType(TrainerDeviceType.bkool);
    final String deviceId = 'mock_device_id';
    test('Test there is device data but no bluetooth device', () async {
      final BTDevice device = null;
      when(mockDataProvider.getTrainerDevice())
                           .thenAnswer((_) async => trainerDevice);
      when(mockBluetoothProvider.getDeviceById(deviceId))
                                .thenAnswer((_) async => null);
      final result = await repository.getDevice();
      expect(result, equals(Right(trainerDevice)));
      result.fold(
        (failure) => {}, 
        (trainerDevice) {
          expect(trainerDevice.device, equals(null));
        });
    });

    test('Test there are device data and bluetooth device', () async {
      when(mockDataProvider.getTrainerDevice())
                           .thenAnswer((_) async => trainerDevice);
      when(mockBluetoothProvider.getDeviceById(deviceId))
                                .thenAnswer((_) async => null);
      final result = await repository.getDevice();
      expect(result, equals(Right(trainerDevice)));
      result.fold(
        (failure) => {}, 
        (trainerDevice) {
          expect(trainerDevice.device, isNot(null));
          expect(trainerDevice.device, isA<BTDevice>());
        });
    });
    
  });

}


