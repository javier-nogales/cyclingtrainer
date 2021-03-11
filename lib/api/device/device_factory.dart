import 'package:trainerapp/api/bluetooth/bt_device_controller.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/bkool_trainer_device.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/api/device/standard_heart_rate_device.dart';

abstract class DeviceFactory<T extends Device> {

  final BTDeviceController _btDeviceController; // BTDeviceController(sl<BluetoothProvider>());

  DeviceFactory(this._btDeviceController);

  T from(DBDevice dbDevice);
}

class TrainerDeviceFactory extends DeviceFactory<TrainerDevice>{

  TrainerDeviceFactory(BTDeviceController btDeviceController)
   : super(btDeviceController);

  TrainerDevice from(DBDevice dbDevice) {
    TrainerDevice outDevice;
    switch (dbDevice.deviceClass) {
      case DeviceClass.bkoolTrainer:
        outDevice = new BkoolTrainerDevice(dbDevice.id, dbDevice.name, dbDevice.type, _btDeviceController);
        break;
      default:
      // TODO: throw exception
    }
    return outDevice;
  }

}

class HeartRateDeviceFactory extends DeviceFactory<HeartRateDevice> {

  HeartRateDeviceFactory(BTDeviceController btDeviceController)
      : super(btDeviceController);

  HeartRateDevice from(DBDevice dbDevice) {
    HeartRateDevice outDevice;
    switch (dbDevice.deviceClass) {
      case DeviceClass.standardHeartRate:
        outDevice = new StandardHeartRateDevice(dbDevice.id, dbDevice.name, dbDevice.type, _btDeviceController);
        break;
      default:
      // TODO: throw exception
    }
    return outDevice;
  }

  @override
  // TODO: implement _btDeviceController
  BTDeviceController get btDeviceController => throw UnimplementedError();
}