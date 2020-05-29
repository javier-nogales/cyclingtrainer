
import 'package:flutter/material.dart';

enum ThemeKeys{light, dark}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    cardTheme: CardTheme(
      margin: EdgeInsets.all(20)
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(
          color: Color(0xff444444),
          width: 1.0
        )
      ),
      // margin: EdgeInsets.all(20),
      color: Color(0xff1c1c1c)
    ),

    textTheme: TextTheme(
      title: TextStyle(fontWeight: FontWeight.w100) 
    )

  );

  // static final ThemeData darkerTheme = ThemeData(
  //   primaryColor: Colors.black,
  //   brightness: Brightness.dark,
  // );

  static ThemeData getThemeFromKey(ThemeKeys themeKey) {
    switch (themeKey) {
      case ThemeKeys.light:
        return lightTheme;
      case ThemeKeys.dark:
        return darkTheme;
      // case other:
      //   return darkerTheme;
      default:
        return lightTheme;
    }
  }
}