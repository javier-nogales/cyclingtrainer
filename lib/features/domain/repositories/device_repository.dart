
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/device_base.dart';

abstract class DeviceRepository<T extends DeviceBase> {

  Future<Either<Failure,T>> getDevice();

}