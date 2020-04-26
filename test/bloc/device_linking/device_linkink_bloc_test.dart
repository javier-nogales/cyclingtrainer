

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/use_cases/linking_use_case.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';
import 'package:trainerapp/core/error/several_failure.dart';

import '../../api/device/mock_device.dart';

class MockDeviceLinkingUseCases extends Mock
    implements LinkingUseCases {}

void main() {

  LinkingUseCases useCases;
  DBDevice dbDevice;
  MockDevice modkDevice;

  setUp(() {
    useCases = MockDeviceLinkingUseCases();
    dbDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
    modkDevice = MockHeartRateDevice();
  });

  blocTest<DeviceLinkingBloc, DeviceLinkingEvent, DeviceLinkingState>(
    'Returns initial state when is created',
    build: () async => DeviceLinkingBloc(useCases: useCases),
    expect: []
  );

  blocTest<DeviceLinkingBloc, DeviceLinkingEvent, DeviceLinkingState>(
      'Returns DeviceLinkingInProgress when DeviceLinkStarted is added',
      build: () async {
        when(useCases.linkDevice(dbDevice))
          .thenAnswer((_) async => Right(dbDevice));
        return DeviceLinkingBloc(useCases: useCases);
      },
      act: (bloc) async => bloc.add(DeviceLinkStarted(dbDevice)),
      wait: Duration(milliseconds: 300),
      expect: [
        DeviceLinkInProgress(),
        DeviceLinkSuccess(DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate))
      ]
  );

  blocTest<DeviceLinkingBloc, DeviceLinkingEvent, DeviceLinkingState>(
      'Returns DeviceLinkingInProgress when DeviceLinkStarted is added',
      build: () async {
        when(useCases.linkDevice(dbDevice))
            .thenAnswer((_) async => Left(SeveralFailure()));
        return DeviceLinkingBloc(useCases: useCases);
      },
      act: (bloc) async => bloc.add(DeviceLinkStarted(dbDevice)),
      wait: Duration(milliseconds: 300),
      expect: [
        DeviceLinkInProgress(),
        DeviceLinkFailure(),
      ]
  );

  blocTest<DeviceLinkingBloc, DeviceLinkingEvent, DeviceLinkingState>(
      'Returns DeviceUnlinkingInProgress when DeviceUnlinkStarted is added',
      build: () async {
        when(useCases.unlinkDevice(modkDevice.device))
            .thenAnswer((_) async => Right(null));
        return DeviceLinkingBloc(useCases: useCases);
      },
      act: (bloc) async => bloc.add(DeviceUnlinkStarted(modkDevice.device)),
      wait: Duration(milliseconds: 300),
      expect: [
        DeviceUnlinkInProgress(),
        DeviceUnlinkSuccess()
      ]
  );

  blocTest<DeviceLinkingBloc, DeviceLinkingEvent, DeviceLinkingState>(
      'Returns DeviceUnlinkingInProgress when DeviceUnlinkStarted is added',
      build: () async {
        when(useCases.unlinkDevice(modkDevice.device))
            .thenAnswer((_) async => Left(SeveralFailure()));
        return DeviceLinkingBloc(useCases: useCases);
      },
      act: (bloc) async => bloc.add(DeviceUnlinkStarted(modkDevice.device)),
      wait: Duration(milliseconds: 300),
      expect: [
        DeviceUnlinkInProgress(),
        DeviceUnlinkFailure()
      ]
  );


}