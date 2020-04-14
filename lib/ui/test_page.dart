import 'package:flutter/material.dart';
import 'package:trainerapp/ui/widgets/bluetooth_scan.dart';

class TestPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
          
          children: <Widget>[
            
            Center(
              child: Text(
                '*** SCROLLABLE TEST PAGE ***', 
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
              ),
            ),

            BluetoothScanResult(),

          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
          
      //   }
      // ),
    );
  }

}