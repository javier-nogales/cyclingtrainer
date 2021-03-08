part of 'bluetooth_scan_bloc.dart';

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
      outString += btDevice.btName + ',';
      }
    });
    outString += ']';
    return outString;
  }
}

class BluetoothScanFailure extends BluetoothScanState {
  @override
  String toString() {
    return 'scanFailure';
  }
}
