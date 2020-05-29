import 'package:flutter/material.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/bloc/device_state/bloc.dart';
import 'package:trainerapp/ui/components/device_status_icon.dart';

import '../../../injection_container.dart';

class BluetoothDevicesKPI extends StatelessWidget {

  final trainerDeviceStateBloc = sl<TrainerDeviceStateBloc>();
  final heartRateDeviceStateBloc = sl<HeartRateDeviceStateBloc>();
  
  @override
  Widget build(BuildContext context) {
    trainerDeviceStateBloc.init();
    heartRateDeviceStateBloc.init();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DeviceStatusIcon(bloc: trainerDeviceStateBloc, type: DeviceType.trainer),
          DeviceStatusIcon(bloc: heartRateDeviceStateBloc, type: DeviceType.heartRate),
          // DeviceStatusIcon(bloc: heartRateDeviceStateBloc, type: DeviceType.cadence),
          // DeviceStatusIcon(bloc: heartRateDeviceStateBloc, type: DeviceType.speed),
        ],
      ),
    );
  }

  void refresh() {
    trainerDeviceStateBloc.refresh();
    heartRateDeviceStateBloc.refresh();
  }
}