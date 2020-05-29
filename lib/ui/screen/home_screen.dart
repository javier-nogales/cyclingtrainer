import 'package:flutter/material.dart';
import 'package:trainerapp/trainer_app.dart';
import 'package:trainerapp/ui/components/dashboards/dashboard.dart';
import 'package:trainerapp/ui/components/kpis/bluetooth_devices_kpi.dart';
import 'package:trainerapp/ui/widgets/devices_board.dart';

class HomeScreen extends StatelessWidget {

  final bluetoothDevicesKPI = BluetoothDevicesKPI();
  
  @override
  Widget build(BuildContext context) {

    print('************************************ HOME SCREEN BUILD');
    
    return Scaffold(

      appBar: AppBar(
        title: Text('Cycling Trainer'),
      ),

      body: Column(
        children: <Widget>[

          BluetoothDevicesDashboard(
            kpi: bluetoothDevicesKPI,
            onTap: () async {
              Object hasChanges = await Navigator.pushNamed(context, devicesRoute);
              if (hasChanges)
                bluetoothDevicesKPI.refresh();
            },
          ),

        ],

      ),

    );

  }

}