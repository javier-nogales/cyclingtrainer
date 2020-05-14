import 'package:flutter/material.dart';
import 'package:trainerapp/trainer_app.dart';
import 'package:trainerapp/ui/widgets/dashboard_button.dart';
import 'package:trainerapp/ui/widgets/devices_board.dart';

import 'devices_screen.dart';

class HomeScreen extends StatelessWidget {

  final devicesStatusBoard = DevicesStatusBoard();
  
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
                board: devicesStatusBoard,
              ),
              onPressed: () async {
                // Navigator.pushReplacementNamed(context, devicesRoute);
                Object hasChanges = await Navigator.pushNamed(context, devicesRoute);
                if (hasChanges) {
                  print('Return from Devices screen with changes');
                  devicesStatusBoard.refresh();
                } else {
                  print('Return from Devices screen without changes');
                }
                
                
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