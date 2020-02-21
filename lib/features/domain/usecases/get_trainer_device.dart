

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/repositories/devices_repository.dart';

class GetTrainerDevice {
  final DevicesRepository repository;

  GetTrainerDevice(this.repository);

  Either<Failure, Stream<TrainerDevice>> execute() {
    repository.getTrainerDevice();
  }
}