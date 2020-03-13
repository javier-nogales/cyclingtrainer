
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';

abstract class TrainerDeviceRepository {

  Future<Either<Failure,TrainerDevice>> getDevice();

}