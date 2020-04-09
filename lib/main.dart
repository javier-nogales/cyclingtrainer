
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
// import 'package:trainerapp/bloc/bluetooth_scan/bloc.dart';
// import 'bloc/bluetooth_scan/bluetooth_scan_bloc.dart';
// import 'bloc/bluetooth_scan/bluetooth_scan_state.dart';
//import 'injection_container.dart' as di;

void main() {
  final fb = FlutterBlue.instance;
  var subscription = fb.scanResults.listen((results) {
    // do something with scan results
    for (ScanResult r in results) {
      print('${r.device.name} found! rssi: ${r.rssi}');
    }
  });
  fb.startScan(timeout: Duration(seconds: 3));
  //di.init();
  //runApp(TrainerApp());
}

/*
class TrainerApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }

}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BluetoothScanBloc bluetoothScanBloc = di.sl<BluetoothScanBloc>();

    return Scaffold(
      body: Center(
        child: Container(
          child: BlocBuilder<BluetoothScanBloc, BluetoothScanState>(
            bloc: bluetoothScanBloc,
            // ignore: missing_return
            builder: (context, state) {
              if (state is InitialBluetoothScanState) {
                bluetoothScanBloc.add(BluetoothScanStarted());
                return Text('InitialState');
              }
              if (state is BluetoothScanLoadInProgress) {
                return Text('LoadInProgress');
              }
              if (state is BluetoothScanListenInProgress) {
//                return ListView.builder(
//                    itemBuilder: (BuildContext context, int index) {
//                      print(index);
//                      if (state.btDevices.isNotEmpty) {
//                        String name = state.btDevices[index].btName;
//                        return Text('Item: $name');
//                      } else {
//                        return Text('Empty list $index');
//                      }
//
//                    }
//                );
                return Text('ListenInProgress');
              }
              if (state is BluetoothScanFinishSuccess) {
                return Text('FinishSuccess');
              }
              if (state is BluetoothScanFailure) {
                return Text('Failure');
              }
            },
          )
        ),
      ),
    );
  }

}

*/