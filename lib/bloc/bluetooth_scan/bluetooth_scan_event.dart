import 'package:equatable/equatable.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';

abstract class BluetoothScanEvent extends Equatable {
  const BluetoothScanEvent();

  @override
  List<Object> get props => [];
}

//class BluetoothScanInitialized extends BluetoothScanEvent {
//  @override
//  String toString() {
//    return 'scanInitialized';
//  }
//}

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

class BluetoothScanDone extends BluetoothScanEvent {
  @override
  String toString() {
    return 'scanDone';
  }
}

class BluetoothScanFailed extends BluetoothScanEvent {
  @override
  String toString() {
    return 'scanFailed';
  }
}
