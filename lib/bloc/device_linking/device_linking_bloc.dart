import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/use_cases/linking_use_case.dart';

part 'device_linking_event.dart';
part 'device_linking_state.dart';

class DeviceLinkingBloc extends Bloc<DeviceLinkingEvent, DeviceLinkingState> {
  final LinkingUseCases _useCases;

  DeviceLinkingBloc({@required LinkingUseCases useCases}) : this._useCases = useCases;

  @override
  DeviceLinkingState get initialState => DeviceLinkingInitial();

  @override
  Stream<DeviceLinkingState> mapEventToState(
    DeviceLinkingEvent event,
  ) async* {
    if (event is DeviceLinkStarted) {
      yield DeviceLinkInProgress();
      _linkDevice(event.dbDevice);
    } else if (event is DeviceLinkSucceeded) {
      yield DeviceLinkSuccess(event.dbDevice);
    } else if (event is DeviceUnlinkStarted) {
      yield DeviceUnlinkInProgress();
      _unlinkDevice(event.device);
    } else if (event is DeviceUnlinkSucceeded) {
      yield DeviceUnlinkSuccess();
    } else if (event is DeviceLinkFailed) {
      yield DeviceLinkFailure();
    } else if (event is DeviceUnlinkFailed) {
      yield DeviceUnlinkFailure();
    }
  }

  void _linkDevice(DBDevice dbDevice) {
    _useCases.linkDevice(dbDevice).then((result) {
      result.fold(
        (failure) => add(DeviceLinkFailed()),
        (dbDevice) => add(DeviceLinkSucceeded(dbDevice))
      );
    });
  }

  void _unlinkDevice(Device device) {
    _useCases.unlinkDevice(device).then((_) {
      _.fold(
        (failure) => add(DeviceUnlinkFailed()),
        (_) => add(DeviceUnlinkSucceeded())
      );
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
