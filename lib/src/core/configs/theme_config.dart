import 'package:flutter/material.dart';

class AppThemeConfig {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xff2ca8e2);
  static Color darkAccent = Color(0xff2ca8e2);
  static Color lightBG = Colors.white;
  static Color darkBG = Color(0xff121212);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
    textTheme: TextTheme(
      button: TextStyle(
        // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
        fontFamily: 'Inter',
      ),
      caption: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.deepPurple[300],
      ),
      headline3: TextStyle(fontFamily: 'Inter'), // display2
      headline1: TextStyle(fontFamily: 'Inter'), // display2
      headline2: TextStyle(fontFamily: 'Inter'), // display2
      headline4: TextStyle(fontFamily: 'Inter'), // display2
      headline5: TextStyle(fontFamily: 'Inter'), // headline
      headline6: TextStyle(fontFamily: 'Inter'),     // title
      subtitle1: TextStyle(fontFamily: 'Inter'),   // subhead
      bodyText1: TextStyle(fontFamily: 'Inter'),    // body2
      bodyText2: TextStyle(fontFamily: 'Inter'),    // body1
      subtitle2: TextStyle(fontFamily: 'Inter'), // subtitle
      overline: TextStyle(fontFamily: 'Inter'),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
    textTheme: TextTheme(
      button: TextStyle(
        // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
        fontFamily: 'Inter',
      ),
      caption: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.deepPurple[300],
      ),
      headline3: TextStyle(fontFamily: 'Inter'), // display2
      headline1: TextStyle(fontFamily: 'Inter'), // display2
      headline2: TextStyle(fontFamily: 'Inter'), // display2
      headline4: TextStyle(fontFamily: 'Inter'), // display2
      headline5: TextStyle(fontFamily: 'Inter'), // headline
      headline6: TextStyle(fontFamily: 'Inter'),     // title
      subtitle1: TextStyle(fontFamily: 'Inter'),   // subhead
      bodyText1: TextStyle(fontFamily: 'Inter'),    // body2
      bodyText2: TextStyle(fontFamily: 'Inter'),    // body1
      subtitle2: TextStyle(fontFamily: 'Inter'), // subtitle
      overline: TextStyle(fontFamily: 'Inter'),
    ),
  );
}