
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/db/db_provider.dart';

abstract class DeviceRepository<T extends Device> {

  Future<T> getDevice();

}

abstract class DeviceRepositoryBase<T extends Device>
    implements DeviceRepository<T> {

  final DBProvider _dataProvider;
  final BluetoothProvider _bluetoothProvider;
  final DeviceFactory<T> _factory;
  T _device;

  DeviceRepositoryBase(this._dataProvider, this._bluetoothProvider, this._factory);

}

class TrainerDeviceRepository extends DeviceRepositoryBase<TrainerDevice> {

  TrainerDeviceRepository(DBProvider dataProvider,
      BluetoothProvider bluetoothProvider,
      DeviceFactory<TrainerDevice> factory)
      : super(dataProvider,
      bluetoothProvider,
      factory);

  @override
  Future<TrainerDevice> getDevice() async {
    if (_device == null) {
      DBDevice dbDevice = await _loadDevice();
      if (dbDevice != null) {
        _device = _factory.from(dbDevice);
        _device.btDevice = await _findDevice(dbDevice.id);
      }
    }
    return _device;
  }

  Future<DBDevice> _loadDevice() async =>
      super._dataProvider.getTrainerDevice();

  Future<BTDevice> _findDevice(String deviceId) async =>
      _bluetoothProvider.findDeviceById(deviceId);
}

class HeartRateDeviceRepository extends DeviceRepositoryBase<HeartRateDevice> {

  HeartRateDeviceRepository(DBProvider dataProvider,
      BluetoothProvider bluetoothProvider,
      DeviceFactory<HeartRateDevice> factory)
      : super(dataProvider,
      bluetoothProvider,
      factory);

  @override
  Future<HeartRateDevice> getDevice() async {
    if (_device == null) {
      DBDevice dbDevice = await _loadDevice();
      if (dbDevice != null) {
        _device = _factory.from(dbDevice);
        _device.btDevice = await _findDevice(dbDevice.id);
      }
    }
    return _device;
  }

  Future<DBDevice> _loadDevice() async =>
      super._dataProvider.getHeartRateDevice();

  Future<BTDevice> _findDevice(String deviceId) async =>
      super._bluetoothProvider.findDeviceById(deviceId);

}