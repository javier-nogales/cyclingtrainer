import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:trainerapp/api/device/device_package.dart';

abstract class DeviceStateEvent extends Equatable {
  const DeviceStateEvent();

  @override
  List<Object> get props => [];
}

class DeviceStateStarted extends DeviceStateEvent {
  @override
  String toString() {
    return 'started';
  }
}

class DeviceStateUpdated extends DeviceStateEvent {
  final DeviceState state;

  const DeviceStateUpdated(this.state);

  @override
  String toString() {
    return 'updated:${describeEnum(state)}';
  }
}

class DeviceStateFailed extends DeviceStateEvent {
  @override
  String toString() {
    return 'failed';
  }
}

