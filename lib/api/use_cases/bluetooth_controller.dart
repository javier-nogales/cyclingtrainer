
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';

class BluetoothController implements BluetoothUseCases {

  final BluetoothProvider _provider;

  BluetoothController(this._provider);

  @override
  Either<Failure,Stream<List<BTDevice>>> fetchDevices() {
    try {
      return Right(_provider.fetchAllDevices());
    } catch (e) {
      return Left(SeveralFailure());
    }
  }

  @override
  Either<Failure, Stream<bool>> isScanning() {
    try {
      return Right(_provider.isScanning());
    } catch (e) {
      return Left(SeveralFailure());
    }
  }


}