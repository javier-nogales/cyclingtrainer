

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/use_cases/heart_rate_device_use_cases.dart';
import 'package:trainerapp/api/use_cases/device_use_cases.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';
import 'package:trainerapp/bloc/device_state/device_state_event.dart';
import 'package:trainerapp/bloc/device_state/device_state_state.dart';
import 'package:trainerapp/bloc/device_state/bloc.dart';
import 'package:trainerapp/core/error/several_failure.dart';

import '../../api/device/mock_device.dart';

class MockHeartRateDeviceUseCases extends Mock
    implements HeartRateDeviceUseCases {}

class MockDeviceLinkingBloc extends MockBloc<DeviceLinkingEvent, DeviceLinkingState>
    implements DeviceLinkingBloc {}

void main() {

  group('HeartRateDeviceStateBloc', () {

    DeviceUseCases useCases;
    MockDeviceLinkingBloc mockDeviceLinkingBloc;
    HeartRateDeviceStateBloc heartRateDeviceStateBloc;
    MockHeartRateDevice mockHeartRateDevice;

    setUp(() {
      useCases = MockHeartRateDeviceUseCases();
      mockDeviceLinkingBloc = MockDeviceLinkingBloc();
      heartRateDeviceStateBloc = HeartRateDeviceStateBloc(useCases: useCases,
                                                          linkingBloc: mockDeviceLinkingBloc);
    });

    blocTest<HeartRateDeviceStateBloc, DeviceStateEvent, DeviceStateState>(
        'Emits HeartRateDeviceStateInitial when is created',
        build: () async => heartRateDeviceStateBloc,
        skip: 0,
        expect: [InitialDeviceState()]
    );

    blocTest<HeartRateDeviceStateBloc, DeviceStateEvent, DeviceStateState>(
        'Emits all states in order when useCase return device',
        build: () async {
          mockHeartRateDevice = MockHeartRateDevice();
          when(useCases.getDeviceState())
              .thenAnswer(
                  (_) async => Right(mockHeartRateDevice.state)
          );
          heartRateDeviceStateBloc.init();
          return heartRateDeviceStateBloc;
        },
        act: (bloc) async {
          await mockHeartRateDevice.addBTState(BTDeviceState.disconnected);
          await mockHeartRateDevice.addBTState(BTDeviceState.connecting);
          await mockHeartRateDevice.addBTState(BTDeviceState.connected);
          await mockHeartRateDevice.addBTState(BTDeviceState.disconnecting);
          await mockHeartRateDevice.addBTState(BTDeviceState.disconnected);
        },
        expect: [
          DeviceStateLoadInProgress(),
          DeviceStateUpdateSuccess(DeviceState.notFound),
          DeviceStateUpdateSuccess(DeviceState.disconnected),
          DeviceStateUpdateSuccess(DeviceState.connected),
          DeviceStateUpdateSuccess(DeviceState.disconnected),
        ]
    );

    blocTest<HeartRateDeviceStateBloc, DeviceStateEvent, DeviceStateState>(
        'Return SeveralFailure when useCase return Failure',
        build: () async {
          mockHeartRateDevice = MockHeartRateDevice();
          when(useCases.getDeviceState())
              .thenAnswer(
                  (_) async => Left(SeveralFailure())
          );
          heartRateDeviceStateBloc.init();
          return heartRateDeviceStateBloc;
        },
        skip: 0,
        expect: [
          InitialDeviceState(),
          DeviceStateFailure(),
        ]
    );

    test(
      'Refresh state when device is linked/unlinked',
      () async {
        mockHeartRateDevice = MockHeartRateDevice();
        
        when(useCases.getDeviceState())
          .thenAnswer((_) async => Right(mockHeartRateDevice.state));

        // Ipmortant!!
        // This test works because the init() method call is triggered by 
        // whenListen(...) and event DeviceUnlinkSuccess()
        whenListen(
          mockDeviceLinkingBloc, 
          Stream<DeviceLinkingState>.fromIterable([DeviceUnlinkSuccess()])
        );

        HeartRateDeviceStateBloc heartRateDeviceStateBloc2 = 
          HeartRateDeviceStateBloc(useCases: useCases, linkingBloc: mockDeviceLinkingBloc);

        expectLater(
          heartRateDeviceStateBloc2,
          emitsInOrder([
            InitialDeviceState(),
            DeviceStateLoadInProgress(),
            DeviceStateUpdateSuccess(DeviceState.notFound),
          ])
        );
      }
    );

    blocTest<HeartRateDeviceStateBloc, DeviceStateEvent, DeviceStateState>(
        'Refresh state when device is linked',
        build: () async {
          mockHeartRateDevice = MockHeartRateDevice();
          when(useCases.getDeviceState())
            .thenAnswer((_) async => Right(mockHeartRateDevice.state));
          // Ipmortant!!
          // This test works because the init() method call is triggered by 
          // whenListen(...) and event DeviceUnlinkSuccess()
          whenListen(
            mockDeviceLinkingBloc, 
            Stream<DeviceLinkingState>.fromIterable([DeviceLinkSuccess(DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate))])
          );
          HeartRateDeviceStateBloc heartRateDeviceStateBloc2 = 
            HeartRateDeviceStateBloc(useCases: useCases, linkingBloc: mockDeviceLinkingBloc);
          return heartRateDeviceStateBloc2;
        },
        wait: Duration(milliseconds: 3000),
        expect: [
          DeviceStateLoadInProgress(),
          DeviceStateUpdateSuccess(DeviceState.notFound),

        ]
    );

  });

}