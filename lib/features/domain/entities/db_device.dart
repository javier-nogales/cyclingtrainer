import 'package:trainerapp/features/domain/entities/device_class.dart';
import 'package:trainerapp/features/domain/entities/device_type.dart';

class DBDevice {

  String id;
  String name;
  DeviceType type;
  DeviceClass deviceClass;

  DBDevice(this.id, this.name, this.type, this.deviceClass);

}