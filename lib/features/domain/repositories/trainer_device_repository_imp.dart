

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/repositories/device_repository_base.dart';
import 'package:trainerapp/features/domain/repositories/trainer_device_repository.dart';

class TrainerDeviceRepositoryImp extends DeviceRepositoryBase 
                              implements TrainerDeviceRepository {
  
  @override
  Either<Failure, Stream<TrainerDevice>> getTrainerDevice() {
    return null;
  }


}