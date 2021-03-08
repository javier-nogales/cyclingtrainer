import 'dart:async';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/use_cases/bt_device_check_use_cases.dart';

part 'bt_device_check_event.dart';
part 'bt_device_check_state.dart';

class BTDeviceCheckBloc extends Bloc<BTDeviceCheckEvent, BTDeviceCheckState> {
  final BTDeviceCheckUseCases _useCases;

  BTDeviceCheckBloc({@required BTDeviceCheckUseCases useCases}) : this._useCases = useCases;

  @override
  BTDeviceCheckState get initialState => BTDeviceCheckInitial();

  @override
  Stream<BTDeviceCheckState> mapEventToState(
    BTDeviceCheckEvent event,
  ) async* {
    if (event is BTDeviceCheckStarted) {
      yield BTDeviceCheckInProgress();
      _checkDevice(event.btDevice);
    } else if (event is BTDeviceCheckSucceeded) {
      yield BTDeviceCheckSuccess(event.dbDevice);
    } else if (event is BTDeviceCheckFailed) {
      yield BTDeviceCheckFailure();
    }
  }

  void _checkDevice(BTDevice btDevice) {
    _useCases.checkDevice(btDevice)
      .then((result) {
        result.fold(
          (failure) => add(BTDeviceCheckFailed()), 
          (dbDevice) => add(BTDeviceCheckSucceeded(dbDevice)),
        );
      });
  }
}
