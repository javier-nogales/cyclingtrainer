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
  String toString() {
    return 'DBDevice:[$id,$name,$type,$deviceClass,]';
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is DBDevice &&
              runtimeType == other.runtimeType &&
              id == other.id;
  @override
  int get hashCode => hashValues(id.hashCode, name.hashCode);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type.toString(),
    "deviceClass": deviceClass.toString()
  };

  factory DBDevice.fromJson(Map<String,dynamic> json) => DBDevice(
    json["id"],
    json["name"],
    DeviceType.values.firstWhere((type) => type.toString() == json["type"]),
    DeviceClass.values.firstWhere((deviceClass) => deviceClass.toString() == json["deviceClass"]),
  );

}