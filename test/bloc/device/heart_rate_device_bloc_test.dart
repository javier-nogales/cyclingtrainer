

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/use_cases/device_use_cases.dart';
import 'package:trainerapp/api/use_cases/heart_rate_device_use_cases.dart';
import 'package:trainerapp/bloc/device/device_bloc.dart';
import 'package:trainerapp/core/error/several_failure.dart';

class MockHeartRateDeviceUseCases extends Mock
    implements HeartRateDeviceUseCases {}

void main() {

  DeviceUseCases useCases;
  Device device;
  DBDevice dbDevice;
  HeartRateDeviceBloc heartRateDeviceBloc;
  
  group('DeviceBloc', () {

    dbDevice = dbDevice = DBDevice("fakeID", "fakeName", 
                                   DeviceType.heartRate, 
                                   DeviceClass.standardHeartRate);
    device = HeartRateDeviceFactory().from(dbDevice);

    setUp(() {
      useCases = MockHeartRateDeviceUseCases();
    });

  blocTest<HeartRateDeviceBloc, DeviceEvent, DeviceBlocState>(
    'Returns initial state when is created',
    build: () async => HeartRateDeviceBloc(useCases: useCases),
    expect: []
  );

  blocTest<HeartRateDeviceBloc, DeviceEvent, DeviceBlocState>(
    'Returns DeviceLoadInProgress state when DeviceStarted event is added',
    build: () async {
      when(useCases.getDevice())
        .thenAnswer((_) async => Right(device));
      return HeartRateDeviceBloc(useCases: useCases);
    },
    act: (bloc) async => bloc.add(DeviceStarted()),
    wait: Duration(milliseconds: 300),
    expect: [
      DeviceLoadInProgress(),
      DeviceUpdateSuccess(device),
    ]
  );

  blocTest<HeartRateDeviceBloc, DeviceEvent, DeviceBlocState>(
    'Returns DeviceFailure state when DeviceFailed event is added',
    build: () async {
      when(useCases.getDevice())
        .thenAnswer((_) async => Left(SeveralFailure()));
      return HeartRateDeviceBloc(useCases: useCases);
    },
    act: (bloc) async => bloc.add(DeviceStarted()),
    wait: Duration(milliseconds: 300),
    expect: [
      DeviceLoadInProgress(),
      DeviceFailure()
    ]
  );

  });

}