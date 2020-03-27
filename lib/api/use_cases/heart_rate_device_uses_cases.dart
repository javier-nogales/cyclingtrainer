

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/api/device/device_package.dart';

abstract class HeartRateDeviceUseCases {

  Future<Either<Failure,Stream<DeviceState>>> getHeartRateDeviceState();

}