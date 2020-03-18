

import 'package:trainerapp/features/domain/entities/device_type.dart';

import 'heart_rate_device.dart';

class StandardHeartRateDevice extends HeartRateDevice {

  StandardHeartRateDevice(String id, String name, DeviceType type) : super(id, name, type);

}