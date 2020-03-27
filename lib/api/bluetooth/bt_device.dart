

import 'package:trainerapp/api/device/identifiers.dart';

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