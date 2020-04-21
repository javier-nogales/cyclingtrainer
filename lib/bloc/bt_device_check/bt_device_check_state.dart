part of 'bt_device_check_bloc.dart';

abstract class BTDeviceCheckState extends Equatable {
  const BTDeviceCheckState();
}

class BTDeviceCheckInitial extends BTDeviceCheckState {
  const BTDeviceCheckInitial();
  
  @override
  List<Object> get props => [];
  @override
  String toString() => 'btDeviceCheckInitial';
}

class BTDeviceCheckInProgress extends BTDeviceCheckState {
  const BTDeviceCheckInProgress();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'btDeviceCheckInProgress';
}

class BTDeviceCheckSuccess extends BTDeviceCheckState {
  final DBDevice dbDevice;

  const BTDeviceCheckSuccess(this.dbDevice);

  @override
  List<Object> get props => [dbDevice];

  @override
  String toString() => 'btDeviceCheckSuccess:[$dbDevice]';
}

class BTDeviceCheckFailure extends BTDeviceCheckState {
  const BTDeviceCheckFailure();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'btDeviceCheckFailure';
}
