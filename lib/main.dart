
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:permission_handler/permission_handler.dart';

// import 'package:trainerapp/bloc/bluetooth_scan/bloc.dart';
// import 'bloc/bluetooth_scan/bluetooth_scan_bloc.dart';
// import 'bloc/bluetooth_scan/bluetooth_scan_state.dart';
//import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //di.init();
  runApp(TrainerApp());
}


class TrainerApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }

}

class Pruebas extends StatelessWidget {
  final _fb = FlutterBlue.instance;
  @override
  Widget build(BuildContext context) {

    _testBluetooth();

    return Scaffold(
      body: Center(
        child: Text('Empezamos las pruebas'),
      ),
    );
  }

  _testBluetooth() async {
//    if (await Permission.location.request().isGranted) {
      _fb.scanResults.listen((results) {
        // do something with scan results
        for (ScanResult r in results) {
          print('${r.device.name} found! rssi: ${r.rssi}');
        }
      });
      _fb.startScan(timeout: Duration(seconds: 3));
//    }
  }

}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.blue,
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Pruebas()
              )
          );
        }
      ),
    );
  }

}

