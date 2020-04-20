import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import '../device/device_package.dart';

class DBDevice {

  String id;
  String name;
  DeviceType type;
  DeviceClass deviceClass;

  DBDevice(this.id, this.name, this.type, this.deviceClass);

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is DBDevice &&
              runtimeType == other.runtimeType &&
              id == other.id;
  @override
  int get hashCode => hashValues(id.hashCode, name.hashCode);

}