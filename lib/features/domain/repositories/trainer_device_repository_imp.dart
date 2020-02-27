

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:trainerapp/core/error/failures.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/repositories/devices_repository.dart';
import 'package:trainerapp/features/domain/repositories/trainer_device_repository.dart';

class TrainerDeviceRepositoryImp implements TrainerDeviceRepository {

////////////////////////////////////////////////////////////
// Repositories
////////////////////////////////////////////////////////////
  final DevicesRepository _devicesRepository;

////////////////////////////////////////////////////////////
// Streams
////////////////////////////////////////////////////////////
  final _trainerDeviceStream = StreamController<TrainerDevice>.broadcast();
  Stream<TrainerDevice> get trainerDevice => _trainerDeviceStream.stream;
  Function(TrainerDevice) get sink => _trainerDeviceStream.sink.add;

////////////////////////////////////////////////////////////
// Constructor
////////////////////////////////////////////////////////////
  TrainerDeviceRepositoryImp(this._devicesRepository);

////////////////////////////////////////////////////////////
// Override methods
////////////////////////////////////////////////////////////
  @override
  Either<Failure, Stream<TrainerDevice>> getTrainerDevice() {
    return null;
  }
}