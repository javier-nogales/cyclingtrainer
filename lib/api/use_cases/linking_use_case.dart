

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';

abstract class LinkingUseCases {

  Future<Either<Failure, DBDevice>> linkDevice(BTDevice btDevice);

  Future<Either<Failure, void>> unlinkDevice(Device device);

}