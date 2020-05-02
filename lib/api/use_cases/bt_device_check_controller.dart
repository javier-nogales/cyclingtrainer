import 'package:dartz/dartz.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/db/db_device_factory.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';

import 'bt_device_check_use_cases.dart';

class BTDeviceCheckController extends BTDeviceCheckUseCases {

  DBDeviceFactory _factory;

  BTDeviceCheckController(this._factory);

  @override
  Future<Either<Failure, DBDevice>> checkDevice(BTDevice btDevice) async {
    try {

      DBDevice dbDevice = await _factory.fromBTDevice(btDevice);
      return Right(dbDevice);
    
    } catch (e) {
      return Left(SeveralFailure());
    }
  }
  
}