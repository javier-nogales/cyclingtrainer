part of 'device_linking_bloc.dart';

abstract class DeviceLinkingState extends Equatable {
  const DeviceLinkingState();
}

class DeviceLinkingInitial extends DeviceLinkingState {
  @override
  List<Object> get props => [];
}

class DeviceLinkInProgress extends DeviceLinkingState {
  @override
  List<Object> get props => [];
}

class DeviceLinkSuccess extends DeviceLinkingState {
  final DBDevice dbDevice;

  const DeviceLinkSuccess(this.dbDevice);

  @override
  List<Object> get props => [dbDevice];

  @override
  String toString() => 'DeviceLinkSuccess:[$dbDevice]';
}

class DeviceLinkFailure extends DeviceLinkingState {
  @override
  List<Object> get props => [];
}

class DeviceUnlinkInProgress extends DeviceLinkingState {
  @override
  List<Object> get props => [];
}

class DeviceUnlinkSuccess extends DeviceLinkingState {
  @override
  List<Object> get props => [];
}

class DeviceUnlinkFailure extends DeviceLinkingState {
  @override
  List<Object> get props => [];
}
