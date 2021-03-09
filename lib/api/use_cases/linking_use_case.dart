import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device.dart';

abstract class LinkingUseCases {

  Future<Either<Failure, DBDevice>> linkDevice(DBDevice dbDevice);

  Future<Either<Failure, void>> unlinkDevice(Device device);

}