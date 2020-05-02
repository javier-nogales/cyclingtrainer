import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainerapp/bloc/device/device_bloc.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';
import 'package:trainerapp/bloc/device_state/bloc.dart';

import '../../injection_container.dart';
import 'custom_dialog.dart';
import 'device_status_icon.dart';

class Devices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final trainerDeviceStateBloc = sl<TrainerDeviceStateBloc>();
    final heartRateDeviceStateBloc = sl<HeartRateDeviceStateBloc>();
    final trainerDeviceBloc = sl<TrainerDeviceBloc>();
    final heartRateDeviceBloc = sl<HeartRateDeviceBloc>();
    final deviceLinkingBloc = BlocProvider.of<DeviceLinkingBloc>(context);

    return Container(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TrainerDeviceStateBloc>(
            create: (BuildContext context) {
              //TrainerDeviceStateBloc bloc = sl<TrainerDeviceStateBloc>();
              trainerDeviceStateBloc.init();
              return trainerDeviceStateBloc;
            }
          ),
          BlocProvider<HeartRateDeviceStateBloc>(
            create: (BuildContext context) {
              //HeartRateDeviceStateBloc bloc = sl<HeartRateDeviceStateBloc>();
              heartRateDeviceStateBloc.init();
              return heartRateDeviceStateBloc;
            }
          )
        ],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            RawMaterialButton(
              child: DeviceStatusIcon<TrainerDeviceStateBloc>(icon: Icons.directions_bike),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => DeviceInfoDialog(
                  deviceBloc: trainerDeviceBloc,
                  deviceLinkingBloc: deviceLinkingBloc,
                )                
              ),
            ),
            Spacer(),
            RawMaterialButton(
              child: DeviceStatusIcon<HeartRateDeviceStateBloc>(icon: FontAwesomeIcons.heartbeat),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => DeviceInfoDialog(
                  deviceBloc: heartRateDeviceBloc,
                  deviceLinkingBloc: deviceLinkingBloc,
                )
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 50),
    );
  }
}


class DeviceInfoDialog extends StatelessWidget {

  final DeviceBloc deviceBloc;
  final DeviceLinkingBloc deviceLinkingBloc;
  
  DeviceInfoDialog({
    @required this.deviceBloc,
    @required this.deviceLinkingBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeviceBloc>(create: (BuildContext context) => deviceBloc),
        BlocProvider<DeviceLinkingBloc>(create: (BuildContext context) => deviceLinkingBloc),
      ],
      child: CustomDialog(
        title: Text('Device Info'),
        content: _DeviceInfoContent(),
        actions: Text('Device Actions'),
      ),
    );
  }
}

class _DeviceInfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<DeviceBloc>(context),
      builder: (context, state) {
        return Text('hemos llegado');
      }
    );
  }
}