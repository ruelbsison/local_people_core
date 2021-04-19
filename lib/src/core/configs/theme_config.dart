import 'package:flutter/material.dart';

class AppThemeConfig {
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xff2ca8e2);
  static Color darkAccent = Color(0xff2ca8e2);
  static Color lightBG = Color.fromRGBO(239, 244, 246, 1); //Color.fromRGBO(222, 232, 237, 0.5); //Color(0xe5e5e5);//Colors.white;
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
        fontFamily: 'RedHatDisplay',
      ),
      headline3: TextStyle(
          fontFamily: 'RedHatDisplay'
      ), // display2
      headline1: TextStyle(
          fontFamily: 'RedHatDisplay'
      ), // display2
      headline2: TextStyle(
          fontFamily: 'RedHatDisplay'
      ), // display2
      headline4: TextStyle(
        fontFamily: "Merriweather",
        color: Color.fromRGBO(0, 63, 92, 1),
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ), // display2
      headline5: TextStyle(
          fontFamily: 'RedHatDisplay'
      ), // headline
      headline6: TextStyle(
          fontFamily: 'Merriweather',
          color: Color.fromRGBO(0, 63, 92, 1),
          fontSize: 22,
          fontWeight: FontWeight.w900,
          //height: 1.5
      ),     // title
      subtitle1: TextStyle(
        fontFamily: 'RedHatDisplay',
        color: Color.fromRGBO(0, 63, 92, 1),
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),   // subhead
      bodyText1: TextStyle (
          color: Color(0xff012b3a), //Color.fromRGBO(87,106,129,1),
          fontFamily: 'RedHatDisplay',
          fontSize: 16,
          fontWeight: FontWeight.w700,
      ),    // body2
      bodyText2: TextStyle(
        fontFamily: 'RedHatDisplay',
        color: Color(0xff012b3a), //Color.fromRGBO(1, 43, 58, 1),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),    // body1
      subtitle2: TextStyle(
        fontFamily: 'RedHatDisplay',
        color: Color.fromRGBO(1, 43, 58, 1),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ), // subtitle
      caption: TextStyle(
        fontFamily: 'RedHatDisplay',
        color: Color.fromRGBO(1, 43, 58, 1),
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
      overline: TextStyle(
          color: Color(0xff012b3a), //Color.fromRGBO(87, 106, 128, 1),
          fontFamily: 'RedHatDisplay',
          fontSize: 10,
          fontWeight: FontWeight.w500,
          //height: 1.5 /*PERCENT not supported*/
      ),
    ),
    textButtonTheme: TextButtonThemeData (
      style: TextButton.styleFrom(
          primary: Color(0xaabacd),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData (
      style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(170, 186, 205, 1),
        onPrimary: Color.fromRGBO(255, 99, 95, 1),
        /*textStyle: TextStyle(
          fontFamily: 'RedHatDisplay',
          color: Color(0xffffff),
          fontSize: 16,
          fontWeight: FontWeight.normal,
        )*/
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData (
      style: OutlinedButton.styleFrom(
          primary: Color(0xaabacd)
      ),
    )
  );

  static ThemeData clientTheme = ThemeData(
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
        headline3: TextStyle(
            fontFamily: 'Inter'
        ), // display2
        headline1: TextStyle(
            fontFamily: 'Inter'
        ), // display2
        headline2: TextStyle(
            fontFamily: 'RedHatDisplay'
        ), // display2
        headline4: TextStyle(
          fontFamily: "Inter",
          color: Color.fromRGBO(0, 63, 92, 1),
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ), // display2
        headline5: TextStyle(
            fontFamily: 'Inter'
        ), // headline
        headline6: TextStyle(
          fontFamily: 'Merriweather',
          color: Color.fromRGBO(0, 63, 92, 1),
          fontSize: 22,
          fontWeight: FontWeight.w900,
          //height: 1.5
        ),     // title
        subtitle1: TextStyle(
          fontFamily: 'Inter',
          color: Color.fromRGBO(0, 63, 92, 1),
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),   // subhead
        bodyText1: TextStyle (
          color: Color(0xff012b3a), //Color.fromRGBO(87,106,129,1),
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),    // body2
        bodyText2: TextStyle(
          fontFamily: 'Inter',
          color: Color(0xff012b3a), //Color.fromRGBO(1, 43, 58, 1),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),    // body1
        subtitle2: TextStyle(
          fontFamily: 'Inter',
          color: Color.fromRGBO(1, 43, 58, 1),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ), // subtitle
        caption: TextStyle(
          fontFamily: 'Inter',
          color: Color.fromRGBO(1, 43, 58, 1),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        overline: TextStyle(
          color: Color(0xff012b3a), //Color.fromRGBO(87, 106, 128, 1),
          fontFamily: 'Inter',
          fontSize: 10,
          fontWeight: FontWeight.w500,
          //height: 1.5 /*PERCENT not supported*/
        ),
      ),
      textButtonTheme: TextButtonThemeData (
        style: TextButton.styleFrom(
          primary: Color(0xaabacd),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData (
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(170, 186, 205, 1),
          onPrimary: Colors.black, //Color.fromRGBO(255, 99, 95, 1),
          // textStyle: TextStyle(
          //   fontFamily: 'RedHatDisplay',
          //   color: Colors.black,
          //   fontSize: 16,
          //   fontWeight: FontWeight.normal,
          // )
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData (
        style: OutlinedButton.styleFrom(
            primary: Color(0xaabacd)
        ),
      )
  );
}