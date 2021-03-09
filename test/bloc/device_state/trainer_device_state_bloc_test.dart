
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/api/use_cases/trainer_device_use_cases.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';
import 'package:trainerapp/bloc/device_state/bloc.dart';
import 'package:trainerapp/core/error/several_failure.dart';

import '../../api/device/mock_device.dart';

class MockTrainerDeviceUseCases extends Mock
    implements TrainerDeviceUseCases {}

class MockDeviceLinkingBloc extends MockBloc<DeviceLinkingEvent, DeviceLinkingState>
    implements DeviceLinkingBloc {}

void main() {

  group('TrainerDeviceStateBloc', () {

    TrainerDeviceUseCases useCases;
    MockDeviceLinkingBloc mockDeviceLinkingBloc;
    TrainerDeviceStateBloc trainerDeviceStateBloc;
    MockTrainerDevice mockTrainerDevice;

    setUp(() {
      useCases = MockTrainerDeviceUseCases();
      mockDeviceLinkingBloc = MockDeviceLinkingBloc();
      trainerDeviceStateBloc = TrainerDeviceStateBloc(useCases: useCases,
                                                      linkingBloc: mockDeviceLinkingBloc);
    });

    blocTest<TrainerDeviceStateBloc, DeviceStateEvent, DeviceStateState>(
        'Emits TrainerDeviceStateInitial when is created',
        build: () async => trainerDeviceStateBloc,
        skip: 0,
        expect: [InitialDeviceState()]
    );

    blocTest<TrainerDeviceStateBloc, DeviceStateEvent, DeviceStateState>(
        'Emits all states in order when useCase return device',
        build: () async {
          mockTrainerDevice = MockTrainerDevice();
          when(useCases.getDeviceState())
              .thenAnswer(
                  (_) async => Right(mockTrainerDevice.state)
          );
          trainerDeviceStateBloc.init();
          return trainerDeviceStateBloc;
        },
        act: (bloc) async {
          await mockTrainerDevice.addBTState(BTDeviceState.disconnected);
          await mockTrainerDevice.addBTState(BTDeviceState.connecting);
          await mockTrainerDevice.addBTState(BTDeviceState.connected);
          await mockTrainerDevice.addBTState(BTDeviceState.disconnecting);
          await mockTrainerDevice.addBTState(BTDeviceState.disconnected);
        },
        expect: [
          DeviceStateLoadInProgress(),
          DeviceStateUpdateSuccess(DeviceState.notFound),
          DeviceStateUpdateSuccess(DeviceState.disconnected),
          DeviceStateUpdateSuccess(DeviceState.connected),
          DeviceStateUpdateSuccess(DeviceState.disconnected),
        ]
    );

    blocTest<TrainerDeviceStateBloc, DeviceStateEvent, DeviceStateState>(
        'Return SeveralFailure when useCase return Failure',
        build: () async
        {
          mockTrainerDevice = MockTrainerDevice();
          when(useCases.getDeviceState())
              .thenAnswer(
                  (_) async => Left(SeveralFailure())
          );
          trainerDeviceStateBloc.init();
          return trainerDeviceStateBloc;
        },
        skip: 0,
        expect: [
          InitialDeviceState(),
          DeviceStateFailure(),
        ]
    );

  });

}