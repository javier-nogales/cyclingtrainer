import 'package:flutter/material.dart';
import 'package:trainerapp/ui/widgets/devices_button.dart';

import 'devices_screen.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        title: Text('Cycling Trainer'),
      ),
      //backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[

          Center(
            child: RawMaterialButton(
              child: DashboardButton(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DevicesScreen()),
                );  
              },
            )
          ),

        ],
      ),

    );

  }

}