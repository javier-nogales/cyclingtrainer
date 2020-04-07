import 'package:equatable/equatable.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/bloc/bluetooth_scan/bloc.dart';

abstract class BluetoothScanState extends Equatable {
  const BluetoothScanState();

  @override
  List<Object> get props => [];
}

class InitialBluetoothScanState extends BluetoothScanState {
  @override
  String toString() {
    return 'initial';
  }
}

class BluetoothScanLoadInProgress extends BluetoothScanState {
  @override
  String toString() {
    return 'scanLoadInProgress';
  }
}

class BluetoothScanListenInProgress extends BluetoothScanState {
  final List<BTDevice> btDevices;

  const BluetoothScanListenInProgress(this.btDevices);
  @override
  List<Object> get props => [btDevices];

  @override
  String toString() {
    String outString = 'scanListenInProgress[';
    btDevices.forEach((btDevice) {
      if(btDevice != null) {
      outString += btDevice.btId.toString() + ',';
      }
    });
    outString += ']';
    return outString;
  }
}

class BluetoothScanFinishSuccess extends BluetoothScanState {
  @override
  String toString() {
    return 'scanFinishSuccess';
  }
}

class BluetoothScanFailure extends BluetoothScanState {
  @override
  String toString() {
    return 'scanFailure';
  }
}
