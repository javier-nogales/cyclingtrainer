
import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';

abstract class BluetoothUseCases {

  Either<Failure,Stream<List<BTDevice>>> fetchDevices();

}