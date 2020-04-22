import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/bloc/bluetooth_is_scanning/bluetooth_is_scanning_bloc.dart';
import 'package:trainerapp/bloc/bt_device_check/bt_device_check_bloc.dart';
import '../../injection_container.dart';

import 'package:trainerapp/bloc/bluetooth_scan/bluetooth_scan_bloc.dart';

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
      color: Colors.teal,
          child: Row(
            children: <Widget>[
              Text('Bluetooth devices:'),
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
    // final BluetoothScanBloc bluetoothScanBloc = BlocProvider.of<BluetoothScanBloc>(context);
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
                      return DeviceCheckDialog(btDevice: btDevice);
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
  final bloc = sl<BTDeviceCheckBloc>();

  DeviceCheckDialog({@required this.btDevice});

  @override
  Widget build(BuildContext context) {
    bloc.add(BTDeviceCheckStarted(btDevice));
    // return Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), 
    //   child: Container(
    //     height: 300.0,
    //     width: 300.0,
    //     child: Column(
    //       children: <Widget>[
    //         _Title(),
    //         _Content(),
    //         _Actions(),
    //       ],
    //     ),
    //   )
    // );
    return BlocProvider(
      create: (context) => bloc,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
        ), 
        child: Container(
          height: 300.0,
          width: 300.0,
          child: Column(
            children: <Widget>[
              _Title(),
              _Content(),
              _Actions(),
            ],
          ),
        )
      )
    );
  }

}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Linking BT Device'),
    );
  }
}
class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<BTDeviceCheckBloc, BTDeviceCheckState>(
        builder: (context, state) {
          if (state is BTDeviceCheckInProgress) {
            return CircularProgressIndicator();
          }
          else if (state is BTDeviceCheckSuccess) {
            return Column(
              children: <Widget>[
                Text('COMPATILBE DEVICE'),
                Text(state.dbDevice.name),
                // Text(state.dbDevice.id),
                Text(state.dbDevice.type.toString()),
              ],
            );
          }
          else if (state is BTDeviceCheckFailure) {
            return Text('Unsupported device');
          }
          else {
            return Text('no deveria estar aqui');
          }
          
        })
      );
  }
}
class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BTDeviceCheckBloc, BTDeviceCheckState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child:  (state is BTDeviceCheckFailure) ? Text('Acept') : Text('Back')
            ),
            if (state is BTDeviceCheckSuccess)
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          children: <Widget>[
                            Text('LinkingDevice'),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    },
                    context: context
                  );
                }, 
                child: Text('Link Device')
              )

          ],
        );
    });
  }
}


Dialog errorDialog = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  child: Container(
    height: 300.0,
    width: 300.0,

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.all(15.0),
          child: Text('Cool', style: TextStyle(color: Colors.red),),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Awesome', style: TextStyle(color: Colors.red),),
        ),
        Padding(padding: EdgeInsets.only(top: 50.0)),
        FlatButton(onPressed: (){
         //Navigator.of(context).pop();
        },
            child: Text('Got It!', style: TextStyle(color: Colors.purple, fontSize: 18.0),))
      ],
    ),
  ),
);