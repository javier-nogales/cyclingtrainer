
import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/bloc/device_state/device_state_event.dart';

void main() {

  group('DeviceStateEvent', () {

    group('DeviceStateStarted', () {
      test('toString returns correct value', () {
        expect(
            DeviceStateStarted().toString(),
            'started'
        );
      });
    });

    group('DeviceStateUpdated', () {
      test('toString returns correct value', () {
        expect(
            DeviceStateUpdated(DeviceState.connected).toString(),
            'updated:connected'
        );
      });
    });

    group('DeviceStateFailed', () {
      test('toString returns correct value', () {
        expect(
            DeviceStateFailed().toString(),
            'failed'
        );
      });
    });

  });

}