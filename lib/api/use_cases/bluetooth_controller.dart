
import 'package:dartz/dartz.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/db/db_provider.dart';
import 'package:trainerapp/api/device/identifiers.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/core/error/several_failure.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/bluetooth_provider.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';

class BluetoothController implements BluetoothUseCases {

  final BluetoothProvider _btProvider;
  final DBProvider _dbProvider;

  BluetoothController(this._btProvider, this._dbProvider);

  @override
  Future<Either<Failure,Stream<List<BTDevice>>>> fetchDevices() async {
    try {
      // List<DBDevice> linkedDevices = await _dbProvider.getAllDevices();
      Stream<List<BTDevice>> btDeviceListStream = _btProvider.fetchAllDevices();
      Stream<List<BTDevice>> filtered = btDeviceListStream.asyncMap((rawDevices) async {
        return await _filterDevices(rawDevices);
      });
      return Right(filtered);
    } catch (e) {
      return Left(SeveralFailure());
    }
  }

  @override
  Either<Failure, Stream<bool>> isScanning() {
    try {
      return Right(_btProvider.isScanning());
    } catch (e) {
      return Left(SeveralFailure());
    }
  }

  Future<List<BTDevice>> _filterDevices(List<BTDevice> rawDevices) async {
    List<DBDevice> linkedDevices = await _dbProvider.getAllDevices();
    List<DeviceID> linkedIds = linkedDevices.map((dbDevice) => DeviceID(dbDevice.id)).toList();
    rawDevices.removeWhere((btDevice) => linkedIds.contains(btDevice.btId));
    rawDevices.removeWhere((btDevice) => btDevice.btName.isEmpty);
    return rawDevices;
  }

}
