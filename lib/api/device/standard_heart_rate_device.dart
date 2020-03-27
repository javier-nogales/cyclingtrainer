

import 'identifiers.dart';
import 'device_package.dart';

class StandardHeartRateDevice extends HeartRateDevice {

  StandardHeartRateDevice(String id, String name, DeviceType type)
      : super(DeviceID(id), name, type);

}