import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:trainerapp/api/use_cases/heart_rate_device_use_cases.dart';
import 'package:trainerapp/api/use_cases/device_use_cases.dart';
import 'package:trainerapp/api/use_cases/trainer_device_use_cases.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';
import 'package:trainerapp/bloc/device_state/device_state_event.dart';
import 'package:trainerapp/bloc/device_state/device_state_state.dart';

abstract class DeviceStateBloc<T extends DeviceUseCases> extends Bloc<DeviceStateEvent, DeviceStateState> {

  final T _useCases;
  final DeviceLinkingBloc _linkingBloc;
  StreamSubscription _stateSubscription;
  StreamSubscription _linkingBlocSubscription;
  
  DeviceStateBloc(this._useCases, this._linkingBloc) {
    _linkingBlocSubscription = _linkingBloc.listen((state) {
      if (state is DeviceUnlinkSuccess) {
        _refresh();
      } else if (state is DeviceLinkSuccess) {
        _refresh();
      } 
    });
  }
  
  @override
  DeviceStateState get initialState => InitialDeviceState();

  // BEWARE!! "init()" is mandatory after instantiating bloc
  Future<void> init() async {
    final result = await _useCases.getDeviceState();
    result.fold(
            (failure) {
              add(DeviceStateFailed());
            },
            (stateStream) {
              if (_stateSubscription == null) {
                _stateSubscription = stateStream.listen((state) {
                  add(DeviceStateUpdated(state));
                });
              }              
              add(DeviceStateStarted());
            }
    );
  }

  Future<void> _refresh() async {
    if (_stateSubscription != null) {
      _stateSubscription.cancel();
      _stateSubscription = null;
    }
    // if (_linkingBlocSubscription != null) {
    //   _linkingBlocSubscription.cancel();
    //   _linkingBlocSubscription = null;
    // }
    init();
  }

  @override
  Stream<DeviceStateState> mapEventToState(
      DeviceStateEvent event,
      ) async* {
    if (event is DeviceStateStarted) {
      yield DeviceStateLoadInProgress();
    } else if (event is DeviceStateUpdated) {
      yield DeviceStateUpdateSuccess(event.state);
    } else if (event is DeviceStateFailed) {
      yield DeviceStateFailure();
    }
  }

  @override
  Future<void> close() {
    if (_stateSubscription != null)
      _stateSubscription.cancel();
    if (_linkingBlocSubscription != null)
      _linkingBlocSubscription.cancel();
    return super.close();
  }
}

class HeartRateDeviceStateBloc 
    extends DeviceStateBloc<HeartRateDeviceUseCases> {
  HeartRateDeviceStateBloc({
    @required HeartRateDeviceUseCases useCases,
    @required DeviceLinkingBloc linkingBloc,
    }) : super(useCases, linkingBloc);
}

class TrainerDeviceStateBloc
    extends DeviceStateBloc<TrainerDeviceUseCases> {
  TrainerDeviceStateBloc({
    @required TrainerDeviceUseCases useCases,
    @required DeviceLinkingBloc linkingBloc,
    }) : super(useCases, linkingBloc);

}