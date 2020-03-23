

import 'package:trainerapp/features/domain/entities/identifiers.dart';

abstract class BTDevice {

  DeviceID get btId;
  String get btName;
  Stream<BTDeviceState> get btState;

}

enum BTDeviceState {
  disconnected,
  connecting,
  connected,
  disconnecting,
}