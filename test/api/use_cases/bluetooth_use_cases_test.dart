
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/api/use_cases/bluetooth_controller.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';

import '../bluetooth/mock_flutter_blue_provider.dart';

class MockBluetoothProvider extends Mock
    implements BluetoothProvider {}

void main() {

  BluetoothProvider provider;
  BluetoothUseCases useCases;
  MockFlutterBlueProvider mockFlutterBlueProvider;

  setUp(() {
    provider = MockBluetoothProvider();
    useCases = BluetoothController(provider);
    mockFlutterBlueProvider = MockFlutterBlueProvider();
  });

  test('Sould return an Stream<List<...>', () {

    when(provider.fetchAllDevices())
        .thenAnswer((_) => mockFlutterBlueProvider.getDeviceList());

    final result = useCases.fetchDevices();

    result.fold(
            (failure) => throw AssertionError(),
            (devices) => expect(devices, isA<Stream<List<BTDevice>>>())
    );

  });

  test('Sould return isConected Stream<bol>', () {
    when(provider.isScanning())
        .thenAnswer((_) async* {yield true;});
    
    final result = useCases.isScanning();

    result.fold(
      (failure) => throw AssertionError(), 
      (isScanning) => expect(isScanning, isA<Stream<bool>>()));
  });

  test('Sould return isConected = true', () {
    when(provider.isScanning())
        .thenAnswer((_) async* {yield true;});
    
    final result = useCases.isScanning();

    result.fold(
      (failure) => throw AssertionError(), 
      (isScanning) => expect(isScanning, emits(true)));
  });

  test('Sould return isConected = false', () {
    when(provider.isScanning())
        .thenAnswer((_) async* {yield false;});
    
    final result = useCases.isScanning();

    result.fold(
      (failure) => throw AssertionError(), 
      (isScanning) => expect(isScanning, emits(false)));
  });

  test('Sould return an Failure', () {

    when(provider.fetchAllDevices())
        .thenThrow(SeveralFailure());

    final result = useCases.fetchDevices();

    result.fold(
            (failure) => expect(failure, isA<Failure>()),
            (devices) => throw AssertionError()
    );

  });

}
