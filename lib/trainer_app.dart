import 'package:flutter/material.dart';
import 'package:trainerapp/ui/home_page.dart';

import 'ui/screen/home_screen.dart';

class TrainerApp extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomeScreen(),
    );
    
  }

}