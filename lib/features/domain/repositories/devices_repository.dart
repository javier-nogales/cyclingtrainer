
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/heart_rate_device.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';

abstract class DevicesRepository {
  
  Either<Failure, Stream<HeartRateDevice>> getCadenceDevice();

  Either<Failure, Stream<HeartRateDevice>> getHeartRateDevice();

  Either<Failure, Stream<TrainerDevice>> getTrainerDevice();

}