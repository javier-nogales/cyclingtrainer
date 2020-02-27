
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/repositories/devices_repository.dart';

abstract class TrainerDeviceRepository {

  Either<Failure, Stream<TrainerDevice>> getTrainerDevice();



}