
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/features/domain/entities/bluetooth/bluetooth_package.dart';
import 'package:trainerapp/features/domain/entities/database/database_package.dart';
import 'package:trainerapp/features/domain/entities/device/device_package.dart';
import 'package:trainerapp/features/domain/entities/device/device_factory.dart';
import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/providers/data_provider.dart';
import 'package:trainerapp/features/domain/repositories/device_repository.dart';

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
  DeviceFactory deviceFactory;
  HeartRateDevice heartRateDevice;
  MockBlueDevice mockBlueDevice;

  setUp((){
    mockBluetoothProvider = MockBluetoothProvider();
    mockDataProvider = MockDataProvider();
    repository = HeartRateDeviceRepository(mockDataProvider, mockBluetoothProvider, HeartRateDeviceFactory());
    dbDevice = DBDevice("fakeID", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
    mockBlueDevice = MockBlueDevice();
    deviceFactory = HeartRateDeviceFactory();
    heartRateDevice = deviceFactory.from(dbDevice);
  });

  test('Test if no device data', () async {

    when(mockDataProvider.getHeartRateDevice())
        .thenAnswer((_) async => null);
    when(mockBluetoothProvider.findDeviceById(dbDevice.id))
        .thenAnswer((_) async => null);

    final result = await repository.getDevice();

    expect(result, equals(Right(null)));

  });

  test('Test if there is device data but no bluetooth device', () async {

    when(mockDataProvider.getHeartRateDevice())
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

    when(mockDataProvider.getHeartRateDevice())
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


