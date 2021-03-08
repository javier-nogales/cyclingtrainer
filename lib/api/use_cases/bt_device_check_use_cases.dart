import 'package:dartz/dartz.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/core/error/failures.dart';

abstract class BTDeviceCheckUseCases {
  
  Future<Either<Failure, DBDevice>> checkDevice(BTDevice btDevice);   

}