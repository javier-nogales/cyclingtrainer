import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/use_cases/device_use_cases.dart';
import 'package:trainerapp/api/use_cases/heart_rate_device_use_cases.dart';
import 'package:trainerapp/api/use_cases/trainer_device_use_cases.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';

part 'device_event.dart';
part 'device_state.dart';

abstract class DeviceBloc extends Bloc<DeviceEvent, DeviceBlocState> {
  
  final DeviceUseCases _useCases;
  final DeviceLinkingBloc _linkingBloc;
  StreamSubscription _linkingBlocSubscription;
  
  DeviceBloc(this._useCases, this._linkingBloc) {
    print('------------------------0 DeviceBloc CONSTRUCTOR --- ' + this._useCases.runtimeType.toString());
    print('------------------------0 DeviceBloc CONSTRUCTOR --- ' + this.runtimeType.toString());
    _linkingBlocSubscription = _linkingBloc.listen((state) {
      if (state is DeviceUnlinkSuccess) {
        add(DeviceStarted());
      } else if (state is DeviceLinkSuccess) {
        print('-------------------------1 --- ' + this.toString());
        print('-------------------------2 --- ' + state.toString());
        print('-------------------------3 --- ' + DeviceStarted().toString());
        //  if (_useCases is TrainerDeviceUseCases){
          print('-------------------------4 --- DEVICE STARTED ADDED (A)' + this.runtimeType.toString());
          add(DeviceStarted());
          print('-------------------------5 --- DEVICE STARTED ADDED (B)' + this.runtimeType.toString());
        //  }
      } 
    });
  }

  @override
  DeviceBlocState get initialState => DeviceInitial();

  @override
  Stream<DeviceBlocState> mapEventToState(
    DeviceEvent event,
  ) async* {
    if (event is DeviceStarted) {
      print('-------------------------6 --- YIELD DEVICE LOAD IN PROGRESS');
      yield DeviceLoadInProgress();
      _loadDevice();
    } else if (event is DeviceUpdated) {
      print('-------------------------7 --- YIELD DEVICE UPDATE SUCCESS');
      yield DeviceUpdateSuccess(event.device);
    } else if (event is DeviceFailed) {
      yield DeviceFailure();
    }
  }

  @override
  Future<void> close() {
    if (_linkingBlocSubscription != null)
      _linkingBlocSubscription.cancel();
    return super.close();
  }

  Future<void> _loadDevice() async {
    _useCases.getDevice().then(
      (result) => result.fold(
        (failure) => add(DeviceFailed()), 
        (device) => add(DeviceUpdated(device)))
    );
  }
}


class HeartRateDeviceBloc extends DeviceBloc {
  HeartRateDeviceBloc({
    @required HeartRateDeviceUseCases useCases,
    @required DeviceLinkingBloc linkingBloc,
  }) : super(useCases, linkingBloc);
}

class TrainerDeviceBloc extends DeviceBloc {
  TrainerDeviceBloc({
    @required TrainerDeviceUseCases useCases,
    @required DeviceLinkingBloc linkingBloc,
  }) : super(useCases, linkingBloc);
}
