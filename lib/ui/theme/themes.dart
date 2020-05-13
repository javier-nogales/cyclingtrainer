
import 'package:flutter/material.dart';

enum ThemeKeys{light, dark}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
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