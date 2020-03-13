

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/providers/data_provider.dart';
import 'package:trainerapp/features/domain/repositories/trainer_device_repository.dart';

class TrainerDeviceRepositoryImpl implements TrainerDeviceRepository {

  final BluetoothProvider _bluetoothProvider;
  final DataProvider _dataProvider;

  TrainerDevice _trainerDevice;

  TrainerDeviceRepositoryImpl(this._dataProvider,
                              this._bluetoothProvider);

  @override
  Future<Either<Failure, TrainerDevice>> getDevice() async {
    if (_trainerDevice == null) {
      _trainerDevice = await _loadDevice();
    }
    return Right(_trainerDevice);
  }
    

  ////////////////////////////////////////////////////////////
  // Private methods
  ////////////////////////////////////////////////////////////
  Future<TrainerDevice> _loadDevice() {
    final trainerDevice = _dataProvider.getTrainerDevice();
    //trainerDevice.getId()
    return trainerDevice;
  }

  






}