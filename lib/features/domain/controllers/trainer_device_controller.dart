

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/features/domain/entities/device/device_package.dart';
import 'package:trainerapp/features/domain/repositories/device_repository.dart';
import 'package:trainerapp/features/domain/usecases/trainer_device_usecases.dart';

class TrainerDeviceController implements TrainerDeviceUseCases {

  final DeviceRepository<TrainerDevice> _repository;

  TrainerDeviceController(this._repository);

  @override
  Future<Either<Failure, Stream<DeviceState>>> getTrainerDeviceState() async {
    try {
      Device device = await _repository.getDevice();
      return Right(device.state);
    } catch (e) {
      return Left(SeveralFailure());
    }
  }

}