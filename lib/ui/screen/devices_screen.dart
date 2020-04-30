

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';
import 'package:trainerapp/ui/widgets/bluetooth_scan.dart';
import 'package:trainerapp/ui/widgets/devices_button.dart';

import '../../injection_container.dart';

class DevicesScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return 
    // BlocProvider(
    //   create: (BuildContext context) => sl<DeviceLinkingBloc>(), 
    //   child: 
      Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Bluetooth Devices'),
              // backgroundColor: Colors.green,
              // expandedHeight: 200.0,
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Image.asset('assets/forest.jpg', fit: BoxFit.cover),
              // ),
            ),
            
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: DashboardButton(),
                  ),

                  BluetoothScanResult()
                ],
              ),
            ),
          ],
        ),
      );
    // );
    
    
  //   return Scaffold (

  //     appBar: AppBar(
  //       title: Text('Bluetooth Devices'),
  //     ),

  //     body: Column(
  //       children: <Widget>[

  //         Center(
  //           child: DashboardButton(),
  //         ),

  //         BluetoothScanResult()

  //       ],
  //     ),
  //   );

  // }
  }
}