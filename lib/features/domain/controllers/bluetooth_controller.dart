

import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/usecases/bluetooth_usecases.dart';

class BluetoothController implements BluetoothUseCases {

  final BluetoothProvider _provider;

  BluetoothController(this._provider);

}