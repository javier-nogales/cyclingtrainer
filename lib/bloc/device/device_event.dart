part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();
}

class DeviceStarted extends DeviceEvent {
  @override
  List<Object> get props => [];
}

class DeviceUpdated extends DeviceEvent {
  final Device device;

  DeviceUpdated(this.device);

  @override
  List<Object> get props => [device];
  @override
  String toString() => 'DeviceUpdated:[$device]';
}

class DeviceFailed extends DeviceEvent {
  @override
  List<Object> get props => [];
}