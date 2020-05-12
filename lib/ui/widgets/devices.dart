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

    // final trainerDeviceStateBloc = BlocProvider.of<TrainerDeviceStateBloc>(context);
    // final heartRateDeviceStateBloc = BlocProvider.of<HeartRateDeviceStateBloc>(context);
    final deviceLinkingBloc = BlocProvider.of<DeviceLinkingBloc>(context);
    // final trainerDeviceBloc = sl<TrainerDeviceBloc>(param1: deviceLinkingBloc);
    // final heartRateDeviceBloc = sl<HeartRateDeviceBloc>(param1: deviceLinkingBloc);
    
    final trainerDeviceBloc = BlocProvider.of<TrainerDeviceBloc>(context);
    final heartRateDeviceBloc = BlocProvider.of<HeartRateDeviceBloc>(context);

    trainerDeviceBloc.add(DeviceStarted());
    heartRateDeviceBloc.add(DeviceStarted());

    return Container(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TrainerDeviceStateBloc>(
            create: (BuildContext context) {
              BlocProvider.of<TrainerDeviceStateBloc>(context).init();
              return BlocProvider.of<TrainerDeviceStateBloc>(context);
            }
          ),
          BlocProvider<HeartRateDeviceStateBloc>(
            create: (BuildContext context) {
              BlocProvider.of<HeartRateDeviceStateBloc>(context).init();
              return BlocProvider.of<HeartRateDeviceStateBloc>(context);
            }
          )
        ],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            RawMaterialButton(
              child: DeviceStatusIcon<TrainerDeviceStateBloc>(icon: Icons.directions_bike),
              onPressed: () {
                DeviceBlocState trainerState = trainerDeviceBloc.state;
                if (trainerState is DeviceUpdateSuccess && trainerState.device != null)
                  return showDialog(
                    context: context,
                    builder: (context) => DeviceInfoDialog(
                      deviceBloc: trainerDeviceBloc,
                      deviceLinkingBloc: deviceLinkingBloc,
                    )                
                  );
              },
            ),
            Spacer(),
            RawMaterialButton(
              child: DeviceStatusIcon<HeartRateDeviceStateBloc>(icon: FontAwesomeIcons.heartbeat),
              onPressed: () {
                DeviceBlocState hrState = heartRateDeviceBloc.state;
                if (hrState is DeviceUpdateSuccess && hrState.device != null)
                  return showDialog(
                    context: context,
                    builder: (context) => DeviceInfoDialog(
                      deviceBloc: heartRateDeviceBloc,
                      deviceLinkingBloc: deviceLinkingBloc,
                    )
                  );
              },
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
    return CustomDialog(
      title: Text('Device Info'),
      content: _DeviceInfoContent(
        deviceLinkingBloc: deviceLinkingBloc,
        deviceBloc: deviceBloc,
      ),
      actions: _DeviceInfoActions(
        deviceLinkingBloc: deviceLinkingBloc,
        deviceBloc: deviceBloc,
      ),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<DeviceBloc>(create: (BuildContext context) => deviceBloc),
    //     //BlocProvider<DeviceLinkingBloc>(create: (BuildContext context) => deviceLinkingBloc),
    //   ],
    //   child: CustomDialog(
    //     title: Text('Device Info'),
    //     content: _DeviceInfoContent(deviceLinkingBloc: deviceLinkingBloc,),
    //     actions: _DeviceInfoActions(deviceLinkingBloc: deviceLinkingBloc),
    //   ),
    // );
  }
}

class _DeviceInfoContent extends StatelessWidget {

  final DeviceBloc deviceBloc;
  final DeviceLinkingBloc deviceLinkingBloc;

  _DeviceInfoContent({
    @required this.deviceLinkingBloc,
    @required this.deviceBloc
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceBlocState>(
      bloc: deviceBloc,
      builder: (context, deviceState) {
        return BlocBuilder<DeviceLinkingBloc, DeviceLinkingState>(
          bloc: deviceLinkingBloc,
          builder: (context, linkingState) {

            if (deviceState is DeviceLoadInProgress || linkingState is DeviceUnlinkInProgress) {
              return CircularProgressIndicator();
            }
            else if (deviceState is DeviceUpdateSuccess && !(linkingState is DeviceUnlinkSuccess)) {
              return Text(deviceState.device.name);
            }
            else if (deviceState is DeviceUpdateSuccess && linkingState is DeviceUnlinkSuccess) {
              return Text('Unlink Success');
            }
            return Text('hemos llegado');  

          },
        );
      }
    );
  }
}

class _DeviceInfoActions extends StatelessWidget {
  
  final DeviceBloc deviceBloc;
  final DeviceLinkingBloc deviceLinkingBloc;

  _DeviceInfoActions({
    @required this.deviceLinkingBloc,
    @required this.deviceBloc
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceBlocState>(
      bloc: deviceBloc,
      builder: (context, deviceState) {

        return BlocBuilder<DeviceLinkingBloc, DeviceLinkingState>(
          bloc: deviceLinkingBloc,
          builder: (context, deviceLinkingState) {
            
            return Row(
              children: <Widget>[

                if (deviceState is DeviceUpdateSuccess)
                  FlatButton(
                    onPressed: () {
                     deviceLinkingBloc.add(DeviceUnlinkStarted(deviceState.device));
                    }, 
                    child: Text('Unlink Device')
                  ),

                // if (deviceLinkingState is DeviceLinkingInitial)
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, 
                    child: Text('Done')
                  ),

              ],
            );

          },
        );
    });
  }
}