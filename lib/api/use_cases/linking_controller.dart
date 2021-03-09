import 'package:dartz/dartz.dart';
import 'package:trainerapp/api/device/device_repository.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/api/db/db_provider.dart';
import 'package:trainerapp/api/use_cases/linking_use_case.dart';

class LinkingController implements LinkingUseCases {

  final DBProvider _dataProvider;
  final TrainerDeviceRepository _trainerDeviceRepository;
  final HeartRateDeviceRepository _heartRateDeviceRepository;


  LinkingController(this._dataProvider,
                    this._trainerDeviceRepository,
                    this._heartRateDeviceRepository,);

  @override
  Future<Either<Failure, DBDevice>> linkDevice(DBDevice dbDevice) async {
    try {
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
      if (device.type == DeviceType.heartRate) {
        _heartRateDeviceRepository.reset();
      } else if (device.type == DeviceType.trainer) {
        _trainerDeviceRepository.reset();
      }
      return Right(result);
    } catch (e) {
      print(e);
      return Left(SeveralFailure());
    }
  }




}