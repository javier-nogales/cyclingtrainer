import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainerapp/bloc/bluetooth_is_scanning/bluetooth_is_scanning_bloc.dart';
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
      color: Colors.red,
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

    // final bluetoothIsScanningBloc = sl<BluetoothIsScanningBloc>();
    // final bluetoothScanBloc = BlocProvider.of<BluetoothScanBloc>(context);

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
              return ListTile(
                title: Text('${state.btDevices[index].btName}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
          );
          // return Text(state.toString());
        }
        if (state is BluetoothScanFailure) {
          return Text(state.toString());
        }
      }
    );
  }
}