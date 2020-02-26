

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/repositories/trainer_device_repository.dart';

class GetTrainerDevice {

  final TrainerDeviceRepository repository;

  GetTrainerDevice(this.repository);

  Either<Failure, Stream<TrainerDevice>> call() {
    return repository.getTrainerDevice();
  }
  
}