
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/db/db_provider.dart';
import 'package:trainerapp/api/use_cases/linking_use_case.dart';

class LinkingController implements LinkingUseCases {

  final DBProvider _dataProvider;

  LinkingController(this._dataProvider);

  @override
  Future<Either<Failure, DBDevice>> linkDevice(BTDevice btDevice) async {
    try {
      DBDevice dbDevice = DBDevice(btDevice.btId.toString(), btDevice.btName, DeviceType.trainer, DeviceClass.bkoolTrainer);
      DBDevice savedDevice = await _dataProvider.createDevice(dbDevice);
      return Right(savedDevice);
    } catch (e) {
      return Left(SeveralFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unlinkDevice(Device device) async {
    try {
      Future<void> result = _dataProvider.deleteDevice(device.id);
      return Right(result);
    } catch (e) {
      return Left(SeveralFailure());
    }
  }




}