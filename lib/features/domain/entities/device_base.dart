

import 'package:trainerapp/features/domain/entities/bt_device.dart';
import 'package:trainerapp/features/domain/entities/devide.dart';

abstract class DeviceBase implements Device{

  BTDevice _device;
  String _id;

  DeviceBase._();

  set device(BTDevice device) => this._device = device;
  get device => this._device;
  String get id => this._id;

}