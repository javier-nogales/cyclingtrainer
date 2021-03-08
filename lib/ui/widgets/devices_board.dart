import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainerapp/bloc/device_state/bloc.dart';
import 'package:trainerapp/bloc/device_state/device_state_bloc.dart';
import 'package:trainerapp/injection_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'device_status_icon.dart';


class DevicesStatusBoard extends StatelessWidget {

  final trainerDeviceStateBloc = sl<TrainerDeviceStateBloc>();
  final heartRateDeviceStateBloc = sl<HeartRateDeviceStateBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TrainerDeviceStateBloc>(
            create: (BuildContext context) {
              TrainerDeviceStateBloc bloc = trainerDeviceStateBloc;
              bloc.init();
              return bloc;
            }
          ),
          BlocProvider<HeartRateDeviceStateBloc>(
            create: (BuildContext context) {
              HeartRateDeviceStateBloc bloc = heartRateDeviceStateBloc;
              bloc.init();
              return bloc;
            }
          )
        ],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DeviceStatusIcon_OLD<TrainerDeviceStateBloc>(icon: Icons.directions_bike),
            DeviceStatusIcon_OLD<HeartRateDeviceStateBloc>(icon: FontAwesomeIcons.heartbeat),
            DeviceStatusIcon_OLD<TrainerDeviceStateBloc>(icon: Icons.directions_bike),
            DeviceStatusIcon_OLD<HeartRateDeviceStateBloc>(icon: FontAwesomeIcons.heartbeat),
          ],
        ),
      ),
    );

  }

  void refresh() {
    trainerDeviceStateBloc.refresh();
    heartRateDeviceStateBloc.refresh();
  }

}

