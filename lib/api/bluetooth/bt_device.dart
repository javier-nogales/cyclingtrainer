

import 'package:flutter/cupertino.dart';
import 'package:trainerapp/api/device/identifiers.dart';

abstract class BTDevice {

  DeviceID get btId;
  String get btName;
  Stream<BTDeviceState> get btState;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is BTDevice &&
              runtimeType == other.runtimeType &&
              btId == other.btId &&
              btName == other.btName;
  @override
  int get hashCode => hashValues(btId.hashCode, btName.hashCode);

}

enum BTDeviceState {
  disconnected,
  connecting,
  connected,
  disconnecting,
}