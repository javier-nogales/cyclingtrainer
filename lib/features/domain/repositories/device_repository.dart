
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/bluetooth/bluetooth_package.dart';
import 'package:trainerapp/features/domain/entities/database/database_package.dart';
import 'package:trainerapp/features/domain/entities/device/device_package.dart';
import 'package:trainerapp/features/domain/entities/device/device_factory.dart';
import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/providers/data_provider.dart';

abstract class DeviceRepository<T extends Device> {

  Future<T> getDevice();

}

abstract class DeviceRepositoryBase<T extends Device>
    implements DeviceRepository<T> {

  final DataProvider _dataProvider;
  final BluetoothProvider _bluetoothProvider;
  final DeviceFactory<T> _factory;
  T _device;

  DeviceRepositoryBase(this._dataProvider, this._bluetoothProvider, this._factory);

}

class TrainerDeviceRepository extends DeviceRepositoryBase<TrainerDevice> {

  TrainerDeviceRepository(DataProvider dataProvider,
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

  HeartRateDeviceRepository(DataProvider dataProvider,
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