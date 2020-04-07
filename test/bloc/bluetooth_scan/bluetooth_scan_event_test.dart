

import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/bloc/bluetooth_scan/bluetooth_scan_event.dart';

void main() {

  group('BluetoothScanEvent', () {

//    group('BluetoothScanInitialized', () {
//      test('toString returns correct value', () {
//        expect(BluetoothScanInitialized().toString(), 'scanInitialized');
//      });
//    });

    group('BluetoothScanStarted', () {
      test('toString returns correct value', () {
        expect(BluetoothScanStarted().toString(), 'scanStarted');
      });
    });

    group('BluetoothScanUpdated', () {
      test('toString returns correct value', () {
        expect(BluetoothScanUpdated([]).toString(), 'scanUpdated');
      });
    });

    group('BluetoothScanFinished', () {
      test('toString returns correct value', () {
        expect(BluetoothScanDone().toString(), 'scanDone');
      });
    });

    group('BluetoothScanFailed', () {
      test('toString returns correct value', () {
        expect(BluetoothScanFailed().toString(), 'scanFailed');
      });
    });

  });

}