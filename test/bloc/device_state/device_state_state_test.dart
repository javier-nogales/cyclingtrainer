
import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/bloc/device_state/device_state_state.dart';

void main() {

  group('HeartRateDeviceStateState', () {

    group('HeartRateDeviceStateInitial', () {
      test('toString returns correct value', () {
        expect(
            InitialDeviceState().toString(),
            'initial'
        );
      });
    });

    group('HeartRateDeviceStateLoadInProgress', () {
      test('toString returns correct value', () {
        expect(
            DeviceStateLoadInProgress().toString(),
            'loadInProgress'
        );
      });
    });

    group('HeartRateDeviceStateUpdateSuccess', () {
      test('toString returns correct value', () {
        expect(
            DeviceStateUpdateSuccess(DeviceState.connected).toString(),
            'updateSuccess:connected'
        );
      });
    });

    group('HeartRateDeviceStateFailure', () {
      test('toString returns correct value', () {
        expect(
            DeviceStateFailure().toString(),
            'failure'
        );
      });
    });

  });

}