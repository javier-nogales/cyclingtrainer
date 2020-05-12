import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/bloc/bluetooth_is_scanning/bluetooth_is_scanning_bloc.dart';
import 'package:trainerapp/bloc/bt_device_check/bt_device_check_bloc.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';
import '../../injection_container.dart';

import 'package:trainerapp/bloc/bluetooth_scan/bluetooth_scan_bloc.dart';

import 'custom_dialog.dart';

class BluetoothScanResult extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BluetoothScanBloc>(),
      child: Column(
        children: <Widget>[
          _BluetoothScanResultHeader(),
          _BluetoothScanResultList(),
        ],
      ),
    );
  }

}


class _BluetoothScanResultHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.blue),
          bottom: BorderSide(color: Colors.blue),
        )
      ),
      child: Row(
        children: <Widget>[
          FaIcon(FontAwesomeIcons.bluetooth),
          Text('Available devices:', style: Theme.of(context).textTheme.title),
          _BluetoothScanResultButton(),
        ],
      ),
    );
  }
}

class _BluetoothScanResultButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: BlocBuilder<BluetoothIsScanningBloc, bool>(
        bloc: sl<BluetoothIsScanningBloc>(),
        builder: (context, state) {
          if (state) {
            return CircularProgressIndicator();
          } else {
            return IconButton(
              icon: Icon(Icons.refresh), 
              onPressed: () {
                BlocProvider.of<BluetoothScanBloc>(context).add(BluetoothScanStarted());
              }
            );
          }
        },
      ),
    );
  }
}

class _BluetoothScanResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DeviceLinkingBloc deviceLinkingBloc = BlocProvider.of<DeviceLinkingBloc>(context);
    return BlocBuilder<BluetoothScanBloc, BluetoothScanState>(
      bloc: BlocProvider.of<BluetoothScanBloc>(context),
      builder: (context, state) {
        if (state is InitialBluetoothScanState) {
          BlocProvider.of<BluetoothScanBloc>(context).add(BluetoothScanStarted());
          return Text(state.toString());
        }
        if (state is BluetoothScanLoadInProgress) {
          return Text(state.toString());
        }
        if (state is BluetoothScanListenInProgress) {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.btDevices.length,
            itemBuilder: (BuildContext context, int index) {
              BTDevice btDevice = state.btDevices[index];
              return ListTile(
                  title: Text('${state.btDevices[index].btName}'),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return DeviceCheckDialog(
                        btDevice: btDevice,
                        deviceLinkingBloc: deviceLinkingBloc,
                      );
                    }
                  ), 
                );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
          );
        } else if (state is BluetoothScanFailure) {
          return Text(state.toString());
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}

class DeviceCheckDialog extends StatelessWidget {

  final BTDevice btDevice;
  final DeviceLinkingBloc deviceLinkingBloc;
  final checkBloc = sl<BTDeviceCheckBloc>();

  DeviceCheckDialog({@required this.btDevice, @required this.deviceLinkingBloc});

  @override
  Widget build(BuildContext context) {
    checkBloc.add(BTDeviceCheckStarted(btDevice));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => checkBloc),
        //BlocProvider(create: (context) => sl<DeviceLinkingBloc>()),
      ],
      child: CustomDialog(
        title: _Title(),
        content: _Content(deviceLinkingBloc: deviceLinkingBloc,),
        actions: _Actions(deviceLinkingBloc: deviceLinkingBloc,),
      )
    );

  }

}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
      bloc: BlocProvider.of<BTDeviceCheckBloc>(context),
      builder: (context, state) {
        if (state is BTDeviceCheckInProgress)
          return Text('Checking device');
        else 
          return Text('Linking BT Device');
      },
    );
  }
}
class _Content extends StatelessWidget {

  final DeviceLinkingBloc deviceLinkingBloc;

  _Content({@required this.deviceLinkingBloc});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<BTDeviceCheckBloc, BTDeviceCheckState>(
      bloc: BlocProvider.of<BTDeviceCheckBloc>(context),
      builder: (context, btDeviceCheckState) {

        return BlocBuilder<DeviceLinkingBloc, DeviceLinkingState>(
          bloc: deviceLinkingBloc,
          builder: (context, deviceLinkingState) {

            if (btDeviceCheckState is BTDeviceCheckInProgress || deviceLinkingState is DeviceLinkInProgress) {
              return CircularProgressIndicator();
            }
            else if (btDeviceCheckState is BTDeviceCheckSuccess) {
              return Column(
                children: <Widget>[
                  Text('COMPATILBE DEVICE'),
                  Text(btDeviceCheckState.dbDevice.name),
                  // Text(state.dbDevice.id),
                  Text(btDeviceCheckState.dbDevice.type.toString()),
                ],
              );
            }
            else if (btDeviceCheckState is BTDeviceCheckFailure) {
              return Text('Unsupported device');
            }
            else {
              return Text('no deveria estar aqui');
            }

          });
      
      });
  }
}
class _Actions extends StatelessWidget {

  final DeviceLinkingBloc deviceLinkingBloc;

  _Actions({@required this.deviceLinkingBloc});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BTDeviceCheckBloc, BTDeviceCheckState>(
      bloc: BlocProvider.of<BTDeviceCheckBloc>(context),
      builder: (context, btDeviceCheckState) {

        return BlocBuilder<DeviceLinkingBloc, DeviceLinkingState>(
          bloc: deviceLinkingBloc,
          builder: (context, deviceLinkingState) {

            return Row(
              children: <Widget>[

                if (btDeviceCheckState is BTDeviceCheckSuccess || btDeviceCheckState is BTDeviceCheckFailure)
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, 
                    child: (btDeviceCheckState is BTDeviceCheckFailure) ? Text('Acept') : Text('Back')
                  ),

                // if (deviceLinkingState is DeviceLinkingInitial && btDeviceCheckState is BTDeviceCheckSuccess)
                if (btDeviceCheckState is BTDeviceCheckSuccess)
                  FlatButton(
                    onPressed: () {
                      deviceLinkingBloc.add(DeviceLinkStarted(btDeviceCheckState.dbDevice));
                    }, 
                    child: Text('Link Device')
                  )

              ],
            );

          },
        );
    });
  }
}
