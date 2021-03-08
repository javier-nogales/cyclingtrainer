import 'package:flutter/material.dart';
import 'package:trainerapp/api/db/sqflite_driver.dart';
import 'package:trainerapp/ui/theme/custom_theme.dart';
import 'package:trainerapp/ui/theme/themes.dart';
import 'injection_container.dart' as di;

import 'package:trainerapp/trainer_app.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await SQFLiteDriver.driver.initDriver();

  runApp(
    
    CustomTheme(

      initialThemeKey: ThemeKeys.dark,
      child: TrainerApp(),

    )

  );

}