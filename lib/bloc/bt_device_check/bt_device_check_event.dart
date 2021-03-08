part of 'bt_device_check_bloc.dart';

abstract class BTDeviceCheckEvent extends Equatable {
  const BTDeviceCheckEvent();
}

class BTDeviceCheckStarted extends BTDeviceCheckEvent {
  final BTDevice btDevice;

  const BTDeviceCheckStarted(this.btDevice);

  @override
  List<Object> get props => [btDevice];

  @override
  String toString() => 'btDeviceCheckStarted:[$btDevice]';
}

class BTDeviceCheckSucceeded extends BTDeviceCheckEvent {
  final DBDevice dbDevice;

  const BTDeviceCheckSucceeded(this.dbDevice);

  @override
  List<Object> get props => [dbDevice];

  @override
  String toString() {
    return 'btDeviceCheckSucceeded:[${dbDevice.id},${dbDevice.name},${dbDevice.type},${dbDevice.deviceClass}]';
  }
}

class BTDeviceCheckFailed extends BTDeviceCheckEvent {
  const BTDeviceCheckFailed();

  @override
  List<Object> get props => [];
  
  @override
  String toString() => 'btDeviceCheckFailed';
}
