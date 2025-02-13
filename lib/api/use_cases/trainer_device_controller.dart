

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/api/device/device_repository.dart';
import 'package:trainerapp/api/use_cases/trainer_device_use_cases.dart';

class TrainerDeviceController implements TrainerDeviceUseCases {

  final TrainerDeviceRepository _repository;

  TrainerDeviceController(this._repository);

  @override
  Future<Either<Failure, Stream<DeviceState>>> getDeviceState() async {
    try {
      Device device = await _repository.getDevice();
      return Right(device.state);
    } catch (e) {
      return Left(SeveralFailure());
    }
  }

  @override
  Future<Either<Failure, Device>> getDevice() async {
    try {
      Device device = await _repository.getDevice();
      return Right(device);
    } catch (e) {
      return Left(SeveralFailure());
    }
  }

}