import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trainerapp/api/db/db_device.dart';

part 'device_linking_event.dart';
part 'device_linking_state.dart';

class DeviceLinkingBloc extends Bloc<DeviceLinkingEvent, DeviceLinkingState> {
  @override
  DeviceLinkingState get initialState => DeviceLinkingInitial();

  @override
  Stream<DeviceLinkingState> mapEventToState(
    DeviceLinkingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
