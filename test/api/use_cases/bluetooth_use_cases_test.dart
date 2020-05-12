
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/db/db_provider.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/api/use_cases/bluetooth_controller.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';

import '../bluetooth/mock_flutter_blue_provider.dart';

class MockBluetoothProvider extends Mock
    implements BluetoothProvider {}

class MockDBPRovider extends Mock
    implements DBProvider {}

void main() {

  BluetoothProvider btProvider;
  DBProvider dbProvider;
  BluetoothUseCases useCases;
  MockFlutterBlueProvider mockFlutterBlueProvider;

  setUp(() {
    btProvider = MockBluetoothProvider();
    useCases = BluetoothController(btProvider, dbProvider);
    mockFlutterBlueProvider = MockFlutterBlueProvider();
  });

  test('Sould return an Stream<List<...>', () async {

    when(btProvider.fetchAllDevices())
        .thenAnswer((_) => mockFlutterBlueProvider.getDeviceList());

    final result = await useCases.fetchDevices();

    result.fold(
            (failure) => throw AssertionError(),
            (devices) => expect(devices, isA<Stream<List<BTDevice>>>())
    );

  });

  test('Sould return isConected Stream<bol>', () {
    when(btProvider.isScanning())
        .thenAnswer((_) async* {yield true;});
    
    final result = useCases.isScanning();

    result.fold(
      (failure) => throw AssertionError(), 
      (isScanning) => expect(isScanning, isA<Stream<bool>>()));
  });

  test('Sould return isConected = true', () {
    when(btProvider.isScanning())
        .thenAnswer((_) async* {yield true;});
    
    final result = useCases.isScanning();

    result.fold(
      (failure) => throw AssertionError(), 
      (isScanning) => expect(isScanning, emits(true)));
  });

  test('Sould return isConected = false', () {
    when(btProvider.isScanning())
        .thenAnswer((_) async* {yield false;});
    
    final result = useCases.isScanning();

    result.fold(
      (failure) => throw AssertionError(), 
      (isScanning) => expect(isScanning, emits(false)));
  });

  test('Sould return an Failure', () async {

    when(btProvider.fetchAllDevices())
        .thenThrow(SeveralFailure());

    final result = await useCases.fetchDevices();

    result.fold(
            (failure) => expect(failure, isA<Failure>()),
            (devices) => throw AssertionError()
    );

  });

}
