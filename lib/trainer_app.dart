import 'package:flutter/material.dart';
import 'package:trainerapp/ui/theme/custom_theme.dart';
import 'package:trainerapp/ui/theme/themes.dart';

import 'ui/screen/home_screen.dart';

class TrainerApp extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Cycling Trainer',
      theme: AppThemes.darkTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
    
  }

}