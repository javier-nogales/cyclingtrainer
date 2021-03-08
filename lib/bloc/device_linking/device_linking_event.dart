part of 'device_linking_bloc.dart';

abstract class DeviceLinkingEvent extends Equatable {
  const DeviceLinkingEvent();
}

class DeviceLinkStarted extends  DeviceLinkingEvent {
  final DBDevice dbDevice;

  DeviceLinkStarted(this.dbDevice);
  
  @override
  List<Object> get props => [dbDevice];

  @override
  String toString() => 'DeviceLinkStarted:[$dbDevice]';
}

class DeviceLinkSucceeded extends DeviceLinkingEvent {
  final DBDevice dbDevice;

  DeviceLinkSucceeded(this.dbDevice);
  
  @override
  List<Object> get props => [dbDevice];

  @override
  String toString() => 'DeviceLinkSucceeded:[$dbDevice]';  
}

class DeviceLinkFailed extends DeviceLinkingEvent {
  @override
  List<Object> get props => [];
}

class DeviceUnlinkStarted extends  DeviceLinkingEvent {
  final Device device;

  DeviceUnlinkStarted(this.device);
  
  @override
  List<Object> get props => [device];

  @override
  String toString() => 'DeviceUnlinkStarted:[$device]';
}

class DeviceUnlinkSucceeded extends DeviceLinkingEvent {
  @override
  List<Object> get props => [];
}

class DeviceUnlinkFailed extends DeviceLinkingEvent {
  @override
  List<Object> get props => [];
}
