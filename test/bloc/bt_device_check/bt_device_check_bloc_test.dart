import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/use_cases/bt_device_check_use_cases.dart';
import 'package:trainerapp/bloc/bt_device_check/bt_device_check_bloc.dart';
import 'package:trainerapp/core/error/several_failure.dart';

import '../../api/bluetooth/mock_blue_device.dart';

class MockBTDeviceCheckUseCases extends Mock 
  implements BTDeviceCheckUseCases {}

void main() {
  
  BTDeviceCheckUseCases useCases;
  BTDevice btDevice;
  DBDevice dbDevice;
  group('BTDeviceCheckBloc', () {

    setUp(() {
      useCases = MockBTDeviceCheckUseCases();
      btDevice = MockBlueDevice()..addId("fakeId")..addName("fakeName");
      dbDevice = DBDevice("fakeId", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
    });

    blocTest<BTDeviceCheckBloc, BTDeviceCheckEvent, BTDeviceCheckState>(
      'Emits InitialBluetoothScanState when is created', 
      build: () async => BTDeviceCheckBloc(useCases: useCases),
      expect: []
    );

    blocTest<BTDeviceCheckBloc, BTDeviceCheckEvent, BTDeviceCheckState>(
      'Emits [BTDeviceCheckInProgress, BTDeviceCheckSuccess] when BTDeviceCheckStarted is added',
      build: () async {
        final bloc = BTDeviceCheckBloc(useCases: useCases);
        when(useCases.checkDevice(btDevice))
          .thenAnswer((_) async => Right(dbDevice));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BTDeviceCheckStarted(btDevice));
      },
      wait: const Duration(milliseconds: 300),
      expect: [
        BTDeviceCheckInProgress(),
        BTDeviceCheckSuccess(DBDevice("fakeId", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer)),
      ]
    );

    blocTest<BTDeviceCheckBloc, BTDeviceCheckEvent, BTDeviceCheckState>(
      'Emits [BTDeviceCheckInProgress, BTDeviceCheckFailure] when BTDevice check fails',
      build: () async {
        final bloc = BTDeviceCheckBloc(useCases: useCases);
        when(useCases.checkDevice(btDevice))
          .thenAnswer((_) async => Left(SeveralFailure()));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(BTDeviceCheckStarted(btDevice));
      },
      wait: const Duration(milliseconds: 300),
      expect: [
        BTDeviceCheckInProgress(),
        BTDeviceCheckFailure(),
      ]
    );

  });

}