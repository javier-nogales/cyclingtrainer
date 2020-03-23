

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/features/domain/controllers/bluetooth_controller.dart';
import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/usecases/bluetooth_usecases.dart';

class MockBluetoothProvider extends Mock
    implements BluetoothProvider {}

void main() {

  BluetoothProvider provider;
  BluetoothUseCases useCases;

  setUp(() {
    provider = MockBluetoothProvider();
    useCases = BluetoothController(provider);
  });

  test('Sould return an Stream<List<...>', () {

  });

}