import 'package:flutter/material.dart';
import 'package:trainerapp/trainer_app.dart';
import 'package:trainerapp/ui/widgets/dashboard_button.dart';
import 'package:trainerapp/ui/widgets/devices_board.dart';

import 'devices_screen.dart';

class HomeScreen extends StatelessWidget {

  HomeSreen() {
    print('************************************ HOME SCREEN CONSTRUCTOR');
  }
  
  @override
  Widget build(BuildContext context) {

    print('************************************ HOME SCREEN BUILD');
    
    return Scaffold(

      appBar: AppBar(
        title: Text('Cycling Trainer'),
      ),
      //backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[

          Center(
            child: RawMaterialButton(
              child: DashboardButton(
                title: DashboardButtonTitle(text: 'Bluetooth Devices',),
                separator: DashboardButtonSeparator(),
                board: Text('*** DEVICES ***'), //DevicesStatusBoard(),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, devicesRoute);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DevicesScreen()),
                // );  
              },
            )
          ),

        ],
      ),

    );

  }

}