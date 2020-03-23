


import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/device/device_package.dart';
import 'package:trainerapp/features/domain/repositories/device_repository.dart';

class TrainerDeviceUseCases {

  DeviceRepository<TrainerDevice> _repository;

  TrainerDeviceUseCases(this._repository);

  Future<Either<Failure,Stream<DeviceState>>> getTrainerDeviceState() async {

    Future<Either<Failure, TrainerDevice>> failureOrDevice = _repository.getDevice();
//    return failureOrDevice.fold(
//            (failure) => null,
//            (device) => device.state;


  }


  
}