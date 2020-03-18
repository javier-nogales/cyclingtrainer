import 'package:trainerapp/features/domain/entities/bt_device.dart';
import 'package:trainerapp/features/domain/entities/device_state.dart';
import 'package:trainerapp/features/domain/entities/device_type.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'device_base.dart';

class BkoolTrainerDevice extends TrainerDevice {

  BkoolTrainerDevice(String id, String name, DeviceType type) : super(id, name, type);

}