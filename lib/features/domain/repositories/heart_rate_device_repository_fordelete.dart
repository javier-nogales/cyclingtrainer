
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/bt_device.dart';
import 'package:trainerapp/features/domain/entities/db_device.dart';
import 'package:trainerapp/features/domain/entities/heart_rate_device.dart';
import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/providers/data_provider.dart';
import 'package:trainerapp/features/domain/repositories/device_repository_base.dart';

class HeartRateDeviceRepository extends DeviceRepositoryBase<HeartRateDevice> {

  HeartRateDeviceRepository(DataProvider dataProvider,
                            BluetoothProvider bluetoothProvider)
      : super(dataProvider,
              bluetoothProvider);

//==============================================================================
// Interface methods implementation
//==============================================================================
  @override
  Future<Either<Failure, HeartRateDevice>> getDevice() async {
    if (device == null) {
      DBDevice dbDevice = await _loadDevice();
      if (dbDevice != null) {
        device = HeartRateDevice.from(dbDevice);
        device.btDevice = await _findDevice(dbDevice.id);
      }
    }
    return Right(device);
  }
//==============================================================================
// Private methods
//==============================================================================
  Future<DBDevice> _loadDevice() async =>
    super.dataProvider.getTrainerDevice();

  Future<BTDevice> _findDevice(String deviceId) async =>
    super.bluetoothProvider.findDeviceById(deviceId);

}

