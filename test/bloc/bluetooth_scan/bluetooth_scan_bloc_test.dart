
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/flutter_blue_device.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';
import 'package:trainerapp/bloc/bluetooth_scan/bloc.dart';

//import '../../api/bluetooth/mock_blue_device.dart';
import '../../api/bluetooth/mock_blue_device.dart';
import '../../api/bluetooth/mock_flutter_blue_provider.dart';

class MockBluetoothUseCases extends Mock
    implements BluetoothUseCases{}

class MockBTDevice extends Mock
    implements BTDevice {}

//class MockFlutterBlueDevice extends Mock
//    implements FlutterBlueDevice {}

void main() {

  group('BluetoothScanBloc', () {

    BluetoothUseCases useCases;
    MockFlutterBlueProvider mockFlutterBlueProvider;
    MockBlueDevice btDevice1 = MockBlueDevice()
      ..addId("fakeId1")
      ..addName("fakeName1");
    MockBlueDevice btDevice2 = MockBlueDevice()
      ..addId("fakeId2")
      ..addName("fakeName2");
    MockBlueDevice btDevice3 = MockBlueDevice()
      ..addId("fakeId3")
      ..addName("fakeName3");

    MockFlutterBlueProvider provider;

    setUp(() {
      useCases = MockBluetoothUseCases();
    });

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits InitialBluetoothScanState when is created',
      build: () async => BluetoothScanBloc(useCases: useCases),
      expect: [InitialBluetoothScanState()],
    );

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
        'Emits InitialBluetoothScanState + BluetoothScanLoadInProgress when scan started',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) => Right(mockFlutterBlueProvider.getDeviceList())
        );
        return bloc;
      },
      act: (bloc) async => bloc.add(BluetoothScanStarted()),
      expect: [
        InitialBluetoothScanState(),
        BluetoothScanLoadInProgress()
      ],
    );

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits BluetoothScanListenInProgress[...] state when provider find btDevices',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) => Right(mockFlutterBlueProvider.getDeviceList())
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BluetoothScanStarted());
        mockFlutterBlueProvider.addDevice(btDevice1);
        await mockFlutterBlueProvider.addDelay(1); // only for complete states
      },
      expect: [
        InitialBluetoothScanState(),
        BluetoothScanLoadInProgress(),
        BluetoothScanListenInProgress([btDevice1]),
      ],
    );

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits BluetoothScanFinishSuccess when scan timeout finsh (done)',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) => Right(mockFlutterBlueProvider.getDeviceList())
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BluetoothScanStarted());
        mockFlutterBlueProvider.addDevice(btDevice1);
        await mockFlutterBlueProvider.doDone();
        await mockFlutterBlueProvider.addDelay(1); // only for complete states
      },
      expect: [
        InitialBluetoothScanState(),
        BluetoothScanLoadInProgress(),
        BluetoothScanListenInProgress([btDevice1]),
        BluetoothScanFinishSuccess(),
      ],
    );

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Emits BluetoothScanFailure when scan fail (error)',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) => Right(mockFlutterBlueProvider.getDeviceList())
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BluetoothScanStarted());
        mockFlutterBlueProvider.addDevice(btDevice1);
        await mockFlutterBlueProvider.addDelay(1); // only for complete states
        mockFlutterBlueProvider.doError();
        await mockFlutterBlueProvider.addDelay(1); // only for complete states
      },
      expect: [
        InitialBluetoothScanState(),
        BluetoothScanLoadInProgress(),
        BluetoothScanListenInProgress([btDevice1]),
        BluetoothScanFailure(),
      ],
    );

    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
      'Restart scan correctly',
      build: () async {
        BluetoothScanBloc bloc = BluetoothScanBloc(useCases: useCases);
        mockFlutterBlueProvider = MockFlutterBlueProvider();
        when(useCases.fetchDevices())
            .thenAnswer(
                (_) => Right(mockFlutterBlueProvider.getDeviceList())
        );
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BluetoothScanStarted());
        mockFlutterBlueProvider.addDevice(btDevice1);
        await mockFlutterBlueProvider.doDone();
        await mockFlutterBlueProvider.addDelay(1); // only for complete states
        bloc.add(BluetoothScanStarted());
      },
      expect: [
        InitialBluetoothScanState(),
        BluetoothScanLoadInProgress(),
        BluetoothScanListenInProgress([btDevice1]),
        BluetoothScanFinishSuccess(),
        BluetoothScanLoadInProgress(),
      ],
    );


//    blocTest<BluetoothScanBloc, BluetoothScanEvent, BluetoothScanState>(
//      'Emits correct states when re-initialize bluetooth scan',
//      build: () {
//        mockFlutterBlueProvider = MockFlutterBlueProvider();
//        when(useCases.fetchDevices())
//            .thenAnswer(
//                (_) => Right(mockFlutterBlueProvider.getDeviceList())
//        );
//        return bluetoothScanBloc;
//      },
//      act: (bloc) async {
//        await mockFlutterBlueProvider.addDevice(btDevice1);
//        await mockFlutterBlueProvider.addDevice(btDevice2);
//        await mockFlutterBlueProvider.doDone();
//
//        await mockFlutterBlueProvider.doNothing(); // only for complete states
//
//        bloc.add(BluetoothScanInitialized());
//        await mockFlutterBlueProvider.addDevice(btDevice1);
//        await mockFlutterBlueProvider.addDevice(btDevice2);
//
//        await mockFlutterBlueProvider.doNothing(); // only for complete states
//      },
//      expect: [
//        InitialBluetoothScanState(),
//        BluetoothScanLoadInProgress(),
//        BluetoothScanListenInProgress([btDevice1, btDevice2]),
//        BluetoothScanFinishSuccess(),
//        InitialBluetoothScanState(),
//        BluetoothScanLoadInProgress(),
//        BluetoothScanListenInProgress([btDevice1, btDevice2]),
//      ],
//    );

  });

}