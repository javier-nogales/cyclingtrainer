
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/db/db_provider.dart';
import 'package:trainerapp/api/device/device_repository.dart';

import '../bluetooth/mock_blue_device.dart';

//==============================================================================
// Mocks
//==============================================================================
class MockBluetoothProvider extends Mock
                         implements BluetoothProvider {}
class MockDataProvider extends Mock
                    implements DBProvider {}

void main() {

  MockBluetoothProvider mockBluetoothProvider;
  MockDataProvider mockDataProvider;
  DeviceRepository<TrainerDevice> repository;
  DBDevice dbDevice;
  DeviceFactory deviceFactory;
  TrainerDevice trainerDevice;
  BTDevice mockBlueDevice;

  setUp((){
    mockBluetoothProvider = MockBluetoothProvider();
    mockDataProvider = MockDataProvider();
    repository = TrainerDeviceRepository(mockDataProvider, mockBluetoothProvider, TrainerDeviceFactory());
    dbDevice = DBDevice("fakeID", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
    mockBlueDevice = MockBlueDevice();
    deviceFactory = TrainerDeviceFactory();
    trainerDevice = deviceFactory.from(dbDevice);
  });

  test('Test if no device data', () async {

    when(mockDataProvider.getTrainerDevice())
        .thenAnswer((_) async => null);
    when(mockBluetoothProvider.findDeviceById(dbDevice.id))
        .thenAnswer((_) async => null);

    final result = await repository.getDevice();

    expect(result, equals(null));

  });

  test('Test if there is device data but no bluetooth device', () async {

    when(mockDataProvider.getTrainerDevice())
        .thenAnswer((_) async => dbDevice);
    when(mockBluetoothProvider.findDeviceById(dbDevice.id))
        .thenAnswer((_) async => null);

    final result = await repository.getDevice();

    expect(result, equals(trainerDevice));
    expect(result.btDevice, null);

  });

  test('Test if there is device data and also a bluetooth device', () async {

    when(mockDataProvider.getTrainerDevice())
        .thenAnswer((_) async => dbDevice);
    when(mockBluetoothProvider.findDeviceById(dbDevice.id))
        .thenAnswer((_) async => mockBlueDevice);

    final result = await repository.getDevice();

    expect(result, equals(trainerDevice));
    expect(result.btDevice, isNotNull);
    expect(result.btDevice, isA<BTDevice>());

  });

}


