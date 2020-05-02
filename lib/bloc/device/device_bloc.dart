import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/use_cases/device_use_cases.dart';
import 'package:trainerapp/api/use_cases/heart_rate_device_use_cases.dart';
import 'package:trainerapp/api/use_cases/trainer_device_use_cases.dart';

part 'device_event.dart';
part 'device_state.dart';

abstract class DeviceBloc<T extends DeviceUseCases> extends Bloc<DeviceEvent, DeviceBlocState> {
  
  final T _useCases;
  
  DeviceBloc(this._useCases);

  @override
  DeviceBlocState get initialState => DeviceInitial();

  @override
  Stream<DeviceBlocState> mapEventToState(
    DeviceEvent event,
  ) async* {
    if (event is DeviceStarted) {
      yield DeviceLoadInProgress();
      _loadDevice();
    } else if (event is DeviceUpdated) {
      yield DeviceUpdateSuccess(event.device);
    } else if (event is DeviceFailed) {
      yield DeviceFailure();
    }
  }

  Future<void> _loadDevice() async {
    _useCases.getDevice().then(
      (result) => result.fold(
        (failure) => add(DeviceFailed()), 
        (device) => add(DeviceUpdated(device)))
    );
  }
}


class HeartRateDeviceBloc extends DeviceBloc<HeartRateDeviceUseCases> {
  HeartRateDeviceBloc({@required HeartRateDeviceUseCases useCases}) : super(useCases);
}

class TrainerDeviceBloc extends DeviceBloc<TrainerDeviceUseCases> {
  TrainerDeviceBloc({@required TrainerDeviceUseCases useCases}) : super(useCases);

}
