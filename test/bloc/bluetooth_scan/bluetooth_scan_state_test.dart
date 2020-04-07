

import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/bloc/bluetooth_scan/bluetooth_scan_state.dart';

void main() {

  group('BluetoothScanState', () {

    group('InitialBluetoothScanState', () {
      test('toString return correct value', () {
        expect(InitialBluetoothScanState().toString(), 'initial');
      });
    });

    group('BluetoothScanLoadInProgress', () {
      test('toString return correct value', () {
        expect(BluetoothScanLoadInProgress().toString(), 'scanLoadInProgress');
      });
    });
    
    group('BluetoothScanListenInProgress', () {
      test('toString return correct value', () {
        expect(BluetoothScanListenInProgress([]).toString(), 'scanListenInProgress[]');
      });
    });

    group('BluetoothScanDone', () {
      test('toString returns correct value', () {
        expect(BluetoothScanFinishSuccess().toString(), 'scanFinishSuccess');
      });
    });

    group('BluetoothScanFailure', () {
      test('toString returns correct value', () {
        expect(BluetoothScanFailure().toString(), 'scanFailure');
      });
    });

  });

}