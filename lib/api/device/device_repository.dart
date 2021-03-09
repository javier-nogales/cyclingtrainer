import 'dart:async';

import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/db/db_provider.dart';
import 'package:trainerapp/core/error/exceptions.dart';

abstract class DeviceRepository<T extends Device> {

  Future<T> getDevice();

  void reset();

}

abstract class DeviceRepositoryBase<T extends Device>
    implements DeviceRepository<T> {

  final DBProvider _dataProvider;
  final DeviceFactory<T> _factory;
  
  Device _device;

  DeviceRepositoryBase(this._dataProvider, this._factory);

  @override
  Future<T> getDevice() async {
    if (_device == null) {
      DBDevice dbDevice = await _loadDevice();
      if (dbDevice != null) {
        _device = _factory.from(dbDevice);
        await _device.initBluetooth();
      }
    }
    return _device;
  }

  @override
  reset() {
    _device = null;
  }

  Future<DBDevice> _loadDevice() async {
    DeviceType type;
    switch(T){
      case TrainerDevice:
        type = DeviceType.trainer;
        break;
      case HeartRateDevice:
        type = DeviceType.heartRate;
        break;
      default:
        throw UnsupportedDeviceException();
    }
    return await _dataProvider.getDeviceByType(type);
  }

}

class TrainerDeviceRepository extends DeviceRepositoryBase<TrainerDevice> {

  TrainerDeviceRepository(
    DBProvider dataProvider,
    DeviceFactory<TrainerDevice> factory
  ) : super(
    dataProvider,
    factory
  );

}

class HeartRateDeviceRepository extends DeviceRepositoryBase<HeartRateDevice> {

  HeartRateDeviceRepository(
    DBProvider dataProvider,
    DeviceFactory<HeartRateDevice> factory
  ) : super(
    dataProvider,
    factory
  );
}

class CadenceDeviceRepository extends DeviceRepositoryBase<CadenceDevice> {

  CadenceDeviceRepository(
    DBProvider dataProvider,
    DeviceFactory<CadenceDevice> factory
  ) : super(
    dataProvider,
    factory
  );

}