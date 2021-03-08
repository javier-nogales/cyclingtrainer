import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';
import 'package:trainerapp/bloc/bluetooth_scan/bluetooth_scan_bloc.dart';
import 'package:trainerapp/core/error/several_failure.dart';

//import '../../api/bluetooth/mock_blue_device.dart';
import '../../api/bluetooth/mock_blue_device.dart';
import '../../api/bluetooth/mock_flutter_blue_provider.dart';

class MockBluetoothUseCases extends Mock
    implements BluetoothUseCases{}

class MockBTDevice extends Mock
    implements BTDevice {}

void main() {

  group('BluetoothScanBloc', () {

    BluetoothUseCases useCases;
    MockFlutterBlueProvider mockFlutterBlueProvider;
    MockBlueDevice btDevice1 = MockBlueDevice()
      ..addId("fakeId1")
      ..addName("fakeName1");

    setUp(() {
      useCases = MockBluetoothUseCases();
    });

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits InitialBluetoothScanState when is created',
      build: () async => BluetoothScanBloc(useCases: useCases),
      skip: 0,
      expect: [InitialBluetoothScanState()],
    );

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits LoadInProgress when scan started',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) async => Right(mockFlutterBlueProvider.getDeviceList())
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BluetoothScanStarted());
      },
      wait: const Duration(milliseconds: 300),
      expect: [
        BluetoothScanLoadInProgress()
      ],
    );

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits ListenInProgress[...] state when provider find btDevices',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) async => Right(mockFlutterBlueProvider.getDeviceList())
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BluetoothScanStarted());
        mockFlutterBlueProvider.addDevice(btDevice1);
      },
      skip: 2,
      wait: const Duration(milliseconds: 300),
      expect: [
        BluetoothScanListenInProgress([btDevice1]),
      ],
    );

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits BluetoothScanFailure when stream emits error',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) async => Right(mockFlutterBlueProvider.getDeviceList())
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BluetoothScanStarted());
        mockFlutterBlueProvider.doError();
      },
      skip: 2,
      wait: const Duration(milliseconds: 300),
      expect: [
        BluetoothScanFailure(),
      ],
    );

  blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits BluetoothScanFailure when useCase return failure',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) async => Left(SeveralFailure())
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BluetoothScanStarted());
      },
      skip: 2,
      wait: const Duration(milliseconds: 300),
      expect: [
        BluetoothScanFailure(),
      ],
    );

  });

}