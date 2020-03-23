


import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/device/device_package.dart';

abstract class TrainerDeviceUseCases {

  Future<Either<Failure,Stream<DeviceState>>> getTrainerDeviceState();



  
}