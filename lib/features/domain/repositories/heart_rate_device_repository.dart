
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/bluetooth/bluetooth_package.dart';
import 'package:trainerapp/features/domain/entities/database/database_package.dart';
import 'package:trainerapp/features/domain/entities/device/device_package.dart';
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

