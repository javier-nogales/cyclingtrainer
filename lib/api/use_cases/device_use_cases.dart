import 'package:dartz/dartz.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/core/error/failures.dart';

abstract class DeviceUseCases {

  Future<Either<Failure,Stream<DeviceState>>> getDeviceState();

  Future<Either<Failure,Device>> getDevice();

}