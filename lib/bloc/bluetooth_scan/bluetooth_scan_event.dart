part of 'bluetooth_scan_bloc.dart';

abstract class BluetoothScanEvent extends Equatable {
  const BluetoothScanEvent();

  @override
  List<Object> get props => [];
}

class BluetoothScanStarted extends BluetoothScanEvent {
  @override
  String toString() {
    return 'scanStarted';
  }
}

class BluetoothScanUpdated extends BluetoothScanEvent {
  final List<BTDevice> btDevices;

  const BluetoothScanUpdated(this.btDevices);

  @override
  String toString() {
    return 'scanUpdated';
  }
}

class BluetoothScanFailed extends BluetoothScanEvent {
  @override
  String toString() {
    return 'scanFailed';
  }
}
