import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:trainerapp/api/device/device_package.dart';

abstract class DeviceStateState extends Equatable {
  const DeviceStateState();

  @override
  List<Object> get props => [];
}

class InitialDeviceState extends DeviceStateState {
  @override
  String toString() {
    return 'initial';
  }
}

class DeviceStateLoadInProgress extends DeviceStateState {
  @override
  String toString() {
    return 'loadInProgress';
  }
}

class DeviceStateUpdateSuccess extends DeviceStateState {
  final DeviceState state;

  const DeviceStateUpdateSuccess(this.state);

  @override
  List<Object> get props => [state];

  @override
  String toString() {
    return 'updateSuccess:${describeEnum(state)}';
  }
}

class DeviceStateFailure extends DeviceStateState {
  @override
  String toString() {
    return 'failure';
  }
}

