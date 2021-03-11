import 'package:trainerapp/api/bluetooth/bt_device_controller.dart';
import 'identifiers.dart';
import 'device.dart';

class StandardHeartRateDevice extends HeartRateDevice {

  StandardHeartRateDevice(String id, String name, DeviceType type, BTDeviceController btDeviceController)
      : super(DeviceID(id), name, type, btDeviceController);

}