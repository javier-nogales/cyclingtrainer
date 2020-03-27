


import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/api/device/device_package.dart';

abstract class TrainerDeviceUseCases {

  Future<Either<Failure,Stream<DeviceState>>> getTrainerDeviceState();
  
}