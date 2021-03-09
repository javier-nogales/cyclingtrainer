

import 'identifiers.dart';
import 'device.dart';

class StandardHeartRateDevice extends HeartRateDevice {

  StandardHeartRateDevice(String id, String name, DeviceType type)
      : super(DeviceID(id), name, type);

}