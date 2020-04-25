

import 'package:flutter_test/flutter_test.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';

void main() {
  
  group('DeviceLinkingState', () {

    group('DeviceLinkinkInitial', () {
      test('toString returns correct value', () {
        expect(DeviceLinkingInitial().toString(), 'DeviceLinkingInitial');
      });
    });

  });

}