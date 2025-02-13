import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainerapp/bloc/device/device_bloc.dart';
import 'package:trainerapp/bloc/device_linking/device_linking_bloc.dart';
import 'package:trainerapp/bloc/device_state/device_state_bloc.dart';
import 'package:trainerapp/trainer_app.dart';
import 'package:trainerapp/ui/widgets/bluetooth_scan.dart';
import 'package:trainerapp/ui/widgets/devices.dart';

import '../../injection_container.dart';

class DevicesScreen extends StatelessWidget {

  bool _hasChanges = false;

  @override
  Widget build(BuildContext context) {

    print('************************************ DEVICE SCREEN BUILD');

    final deviceLinkingBloc = sl<DeviceLinkingBloc>();

    deviceLinkingBloc.listen((state) {
      if (state is DeviceLinkSuccess || state is DeviceUnlinkSuccess) 
        _hasChanges = true;
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => deviceLinkingBloc),
        BlocProvider(create: (context) => sl<SynchronizedTrainerDeviceStateBloc>(param1: deviceLinkingBloc)),
        BlocProvider(create: (context) => sl<SynchronizedHeartRateDeviceStateBloc>(param1: deviceLinkingBloc)),
        BlocProvider(create: (context) => sl<TrainerDeviceBloc>(param1: deviceLinkingBloc)),
        BlocProvider(create: (context) => sl<HeartRateDeviceBloc>(param1: deviceLinkingBloc)),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Bluetooth Devices'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back), 
                onPressed: () {
                  Navigator.of(context).pop(_hasChanges);
                }
              )
            
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
                    child: Devices(),
                  ),

                  BluetoothScanResult()
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: <Widget>[
    //       SliverAppBar(
    //         title: Text('Bluetooth Devices'),
    //         // backgroundColor: Colors.green,
    //         // expandedHeight: 200.0,
    //         // flexibleSpace: FlexibleSpaceBar(
    //         //   background: Image.asset('assets/forest.jpg', fit: BoxFit.cover),
    //         // ),
    //       ),
          
    //       SliverList(
    //         delegate: SliverChildListDelegate(
    //           [
    //             Center(
    //               child: Devices(),
    //             ),

    //             BluetoothScanResult()
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    // );
    
  }
}