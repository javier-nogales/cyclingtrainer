import 'dart:async';

import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
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
  //final BluetoothProvider _bluetoothProvider;
  final DeviceFactory<T> _factory;
  
  Device _device;
  //StreamSubscription _monitoringStateSubscription;

  DeviceRepositoryBase(this._dataProvider, this._factory);

  @override
  Future<T> getDevice() async {
    if (_device == null) {
      DBDevice dbDevice = await _loadDevice();
      if (dbDevice != null) {
        _device = _factory.from(dbDevice);
        await _device.initBluetooth();

        // _device.btDevice = await _findDevice(dbDevice.id);
        // if (_device.btDevice != null) {
        //   _device.btDevice.ensureConnection(
        //     onConnect: () {
        //       print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] ** Device is connected');
        //     },
        //     onConnectionLost: () {
        //       print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] ** Device Connection lost');
        //     }
        //   );
        // }
        // if (_device.btDevice == null)
        //   _launchActiveSearch();
      }
    }
    return _device;
  }

  @override
  reset() {
    _device = null;
  }

  // void _launchActiveSearch() {
  //   print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Activating device search');

  //   Timer.periodic(
  //     Duration(seconds: 5),
  //     (timer) async {
  //       print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Finding device ...');

  //       final btDevice = await _findDevice(_device.id.toString());
  //       if (btDevice != null) {
  //         timer.cancel();
  //         _device.btDevice = btDevice;

  //         print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Device found');

  //         _device.state.listen((state) {
  //           print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Device state has change to $state');
  //         });

  //         // _monitoringStateSubscription = _device.state.listen((state) {
  //         //   if (state == DeviceState.notFound) {
  //         //     _device.btDevice = null;
  //         //     _monitoringStateSubscription.cancel();
  //         //     _launchActiveSearch();
  //         //   }
  //         // },
  //         // onError: () => print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Error monitoring device state'),
  //         // cancelOnError: true
  //         // );

          
  //       }

  //     }

  //   );
  // }

  Future<DBDevice> _loadDevice() async {
    DeviceType type;
    switch(T){
      case TrainerDevice:
        type = DeviceType.trainer;
        break;
      case HeartRateDevice:
        type = DeviceType.heartRate;
        break;
      // case CadenceDevice:
      //   type = DeviceType.trainer;
      //   break;
      // case SpeedDevice:
      //   type = DeviceType.trainer;
      //   break;
      default:
        throw UnsupportedDeviceException();
    }
    return await _dataProvider.getDeviceByType(type);
  }

  // Future<BTDevice> _findDevice(String deviceId) async =>
  //   _bluetoothProvider.findDeviceById(deviceId);

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