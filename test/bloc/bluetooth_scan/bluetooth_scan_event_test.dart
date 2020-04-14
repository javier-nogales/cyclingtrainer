import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/bloc/bluetooth_scan/bluetooth_scan_bloc.dart';

void main() {

  group('BluetoothScanEvent', () {

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

    group('BluetoothScanFailed', () {
      test('toString returns correct value', () {
        expect(BluetoothScanFailed().toString(), 'scanFailed');
      });
    });

  });

}