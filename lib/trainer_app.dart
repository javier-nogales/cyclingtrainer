import 'package:flutter/material.dart';
import 'package:trainerapp/ui/screen/devices_screen.dart';
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
      onGenerateRoute: Router.generateRoute,
      initialRoute: homeRoute,
    );
    
  }

}

const String homeRoute = '/';
const String devicesRoute = 'devices';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case devicesRoute:
        return MaterialPageRoute(builder: (_) => DevicesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}')
            ),
          ));
    }
  }
}