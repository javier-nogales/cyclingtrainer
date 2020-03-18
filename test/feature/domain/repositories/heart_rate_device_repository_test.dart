
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/features/domain/entities/bt_device.dart';
import 'package:trainerapp/features/domain/entities/db_device.dart';
import 'package:trainerapp/features/domain/entities/device_type.dart';
import 'package:trainerapp/features/domain/entities/heart_rate_device.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/entities/device_class.dart';
import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/providers/data_provider.dart';
import 'package:trainerapp/features/domain/repositories/device_repository.dart';
import 'package:trainerapp/features/domain/repositories/heart_rate_device_repository.dart';
import 'package:trainerapp/features/domain/repositories/trainer_device_repository.dart';

import '../mocks/mock_blue_device.dart';

//==============================================================================
// Mocks
//==============================================================================
class MockBluetoothProvider extends Mock
                         implements BluetoothProvider {}
class MockDataProvider extends Mock
                    implements DataProvider {}

void main() {

  MockBluetoothProvider mockBluetoothProvider;
  MockDataProvider mockDataProvider;
  DeviceRepository<HeartRateDevice> repository;
  DBDevice dbDevice;
  HeartRateDevice heartRateDevice;
  MockBlueDevice mockBlueDevice;

  setUp((){
    mockBluetoothProvider = MockBluetoothProvider();
    mockDataProvider = MockDataProvider();
    repository = HeartRateDeviceRepository(mockDataProvider, mockBluetoothProvider);
    dbDevice = DBDevice("fakeID", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
    mockBlueDevice = MockBlueDevice();
    heartRateDevice = HeartRateDevice.from(dbDevice);
  });

  test('Test if no device data', () async {

    when(mockDataProvider.getTrainerDevice())
        .thenAnswer((_) async => null);
    when(mockBluetoothProvider.findDeviceById(dbDevice.id))
        .thenAnswer((_) async => null);

    final result = await repository.getDevice();

    expect(result, equals(Right(null)));

  });

  test('Test if there is device data but no bluetooth device', () async {

    when(mockDataProvider.getTrainerDevice())
        .thenAnswer((_) async => dbDevice);
    when(mockBluetoothProvider.findDeviceById(dbDevice.id))
        .thenAnswer((_) async => null);

    final result = await repository.getDevice();

    expect(result, equals(Right(heartRateDevice)));
    result.fold(
        (failure) => {},
        (trainerDevice) {
      expect(trainerDevice.btDevice, null);
    });

  });

  test('Test if there is device data and also a bluetooth device', () async {

    when(mockDataProvider.getTrainerDevice())
        .thenAnswer((_) async => dbDevice);
    when(mockBluetoothProvider.findDeviceById(dbDevice.id))
        .thenAnswer((_) async => mockBlueDevice);

    final result = await repository.getDevice();

    expect(result, equals(Right(heartRateDevice)));
    result.fold(
            (failure) => {},
            (trainerDevice) {
          expect(trainerDevice.btDevice, isNotNull);
          expect(trainerDevice.btDevice, isA<BTDevice>());
        });


  });

}


