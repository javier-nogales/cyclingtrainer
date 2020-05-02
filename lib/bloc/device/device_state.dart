part of 'device_bloc.dart';

abstract class DeviceBlocState extends Equatable {
  const DeviceBlocState();
}

class DeviceInitial extends DeviceBlocState {
  @override
  List<Object> get props => [];

}

class DeviceLoadInProgress extends DeviceBlocState {
  @override
  List<Object> get props => [];
}

class DeviceUpdateSuccess extends DeviceBlocState {
  final Device device;

  DeviceUpdateSuccess(this.device);

  @override
  List<Object> get props => [device];
  
  @override
  String toString() => 'DeviceUpdateSuccess:[$device]';
}

class DeviceFailure extends DeviceBlocState {
  @override
  List<Object> get props => [];
}
