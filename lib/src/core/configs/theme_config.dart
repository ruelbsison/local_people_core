import 'package:flutter/material.dart';

class AppThemeConfig {
  final ThemeData kLocalPeopleClientTheme = _buildLightTheme();
  final ThemeData kLocalPeopleTraderTheme = _buildDarkTheme();

  static TextTheme _buildTraderTextTheme(TextTheme base) {
    return base
        .copyWith(
      headline6: base.headline6.copyWith(
        fontFamily: 'Merriweather',
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
      subtitle1: base.subtitle1.copyWith(
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      subtitle2: base.subtitle2.copyWith(
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      caption: base.caption.copyWith(
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      button: base.button.copyWith(
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      overline: base.overline.copyWith(
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.w700,
        fontSize: 10,
      ),
    )
        .apply(
      displayColor: Color(0xFF012B3A),
      bodyColor: Color(0xFF012B3A),
    );
  }

  static TextTheme _buildClientTextTheme(TextTheme base) {
    return base
        .copyWith(
      headline6: base.headline6.copyWith(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      subtitle1: base.subtitle1.copyWith(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      subtitle2: base.subtitle2.copyWith(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      caption: base.caption.copyWith(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      button: base.button.copyWith(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      overline: base.overline.copyWith(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    )
        .apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
    );
  }

  static ThemeData _buildLightTheme() {
    final MaterialColor themeMaterialColor =
    createMaterialColor(const Color.fromRGBO(48, 49, 60, 1));
    /*const Color primaryColor = Color(0xFFEFF4F6);
    const Color secondaryColor = Color(0xFFFFFFFF);
    final ColorScheme lightColorScheme = const ColorScheme.light().copyWith(
      primary: Color(0xFFEFF4F6),
      primaryVariant: Color(0xFFE4ECEF),
      secondary: Color(0xFFFDFEFE),
      secondaryVariant:  Color(0xFFE4ECEF),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFEFF4F6),
      error: Color(0xFFB00020),
      onPrimary: Color(0xFFE4ECEF),
      onSecondary: Color(0xFFE4ECEF),
      onSurface: Color(0xFFE4ECEF),
      onBackground: Color(0xFFE4ECEF),
      onError: Color(0xFFFFFFFF),
      brightness: Brightness.light,
    );*/
    Color lightPrimary = Colors.white;
    Color darkPrimary = Color(0xff1f1f1f);
    Color lightAccent = Color(0xff2ca8e2); //Color(0x7fdee8ec); //
    Color darkAccent = Color(0xff2ca8e2); //Color(0x7fdee8ec);
    Color lightBG = Color.fromRGBO(239, 244, 246, 1); //Color.fromRGBO(222, 232, 237, 0.5); //Color(0xe5e5e5);//Colors.white;
    Color darkBG = Color(0xff121212);
    final ColorScheme lightColorScheme = const ColorScheme.light().copyWith(
      primary: lightPrimary,
      primaryVariant: lightPrimary,
      secondary: lightBG,
      secondaryVariant:  lightBG,
      surface: Color(0xFFFFFFFF),
      background: lightBG,
      error: Color(0xFFB00020),
      onPrimary: darkBG,
      onSecondary: lightAccent,
      brightness: Brightness.light,
    );
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Colors.grey[300],
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      backgroundColor: lightBG,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBG,
      colorScheme: lightColorScheme,
      indicatorColor: Colors.white,
      toggleableActiveColor: const Color(0xFF1E88E5),
      splashColor: lightPrimary, //Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      errorColor: const Color(0xFFB00020),
      brightness: Brightness.light,
      /*accentColorBrightness: Brightness.dark,
      colorScheme: lightColorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      toggleableActiveColor: const Color(0xFF1E88E5),
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: primaryColor, //Colors.white,
      scaffoldBackgroundColor: primaryColor, //Colors.white,
      backgroundColor: primaryColor, //Colors.white,
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: base.buttonTheme.colorScheme,
        textTheme: ButtonTextTheme.accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      ),*/
      iconTheme: base.iconTheme.copyWith(color: Colors.black),
      accentIconTheme: base.accentIconTheme.copyWith(color: Colors.black),
      primaryIconTheme: base.primaryIconTheme.copyWith(color: Colors.black),
      // buttonTheme: base.buttonTheme.copyWith(
      //   buttonColor: Color(0xffe5e5e5),
      //   textTheme: ButtonTextTheme.primary,
      //   colorScheme:
      //   base.colorScheme.copyWith(secondary: Colors.black), // Text color
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      // ),
      buttonTheme: ButtonThemeData(
        buttonColor: themeMaterialColor.shade500,
        disabledColor: themeMaterialColor.withRed(200),
        splashColor: themeMaterialColor.shade50,
        textTheme: ButtonTextTheme.primary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Color(0xaabacd),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData (
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(170, 186, 205, 1),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData (
        style: OutlinedButton.styleFrom(primary: Color(0xaabacd)),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
        ),
      ),
      textTheme: _buildClientTextTheme(base.textTheme),
      primaryTextTheme: _buildClientTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildClientTextTheme(base.accentTextTheme),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: lightPrimary,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }

  /// Creates a [MaterialColor] based on the supplied [Color]
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final r = color.red, g = color.green, b = color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch as Map<int, Color>);
  }

  static ThemeData _buildDarkTheme() {
    final MaterialColor themeMaterialColor =
    createMaterialColor(const Color.fromRGBO(170, 186, 205, 1),);
    /*const Color primaryColor = Color(0xFFEFF4F6);
    const Color secondaryColor = Color(0xFFFFFFFF);
    final ColorScheme darkColorScheme = const ColorScheme.dark().copyWith(
      primary: Color(0xFFEFF4F6),
      primaryVariant: Color(0xFFE4ECEF),
      secondary: Color(0xFFFDFEFE),
      secondaryVariant:  Color(0xFFE4ECEF),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFEFF4F6),
      error: Color(0xFFB00020),
      onPrimary: Color(0xFFE4ECEF),
      onSecondary: Color(0xFFE4ECEF),
      onSurface: Color(0xFFE4ECEF),
      onBackground: Color(0xFFE4ECEF),
      onError: Color(0xFFFFFFFF),
      brightness: Brightness.dark,
    );*/
    Color lightPrimary = Colors.white;
    Color darkPrimary = Color(0xff1f1f1f);
    Color lightAccent = Color(0xff2ca8e2);
    Color darkAccent = Color(0xff2ca8e2);
    Color lightBG = Color(0x7fdee8ec); //Color.fromRGBO(239, 244, 246, 1); //Color.fromRGBO(222, 232, 237, 0.5); //Color(0xe5e5e5);//Colors.white;
    Color darkBG = Color(0xff121212);
    /*colorScheme: ColorScheme.light(
      primary: lightPrimary,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),*/
    final ColorScheme lightColorScheme = const ColorScheme.light().copyWith(
      primary: lightPrimary,
      primaryVariant: lightPrimary,
      secondary: lightBG,
      secondaryVariant:  lightBG,
      surface: Color(0xFFFFFFFF),
      background: lightBG,
      error: Color(0xFFB00020),
      onPrimary: darkBG,
      onSecondary: lightAccent,
      brightness: Brightness.light,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      backgroundColor: lightBG,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBG,
      //colorScheme: ColorScheme.fromSwatch(

      //),
      indicatorColor: Colors.white,
      toggleableActiveColor: const Color(0xFF1E88E5),
      splashColor: lightPrimary, //Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      errorColor: const Color(0xFFB00020),
      brightness: Brightness.light,
      /*accentColorBrightness: Brightness.dark,
      colorScheme: darkColorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      toggleableActiveColor: const Color(0xFF1E88E5),
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: primaryColor, //Colors.white,
      scaffoldBackgroundColor: primaryColor, //Colors.white,
      backgroundColor: primaryColor, //Colors.white,
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: base.buttonTheme.colorScheme,
        textTheme: ButtonTextTheme.accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      ),*/
      iconTheme: base.iconTheme.copyWith(color: Colors.black,),
      accentIconTheme: base.accentIconTheme.copyWith(color: Colors.black),
      primaryIconTheme: base.primaryIconTheme.copyWith(color: Colors.black),
      // buttonTheme: base.buttonTheme.copyWith(
      //   buttonColor: Color(0xffe5e5e5),
      //   textTheme: ButtonTextTheme.primary,
      //   colorScheme:
      //   base.colorScheme.copyWith(secondary: Colors.black), // Text color
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      // ),
      buttonTheme: ButtonThemeData(
        buttonColor: themeMaterialColor.shade500,
        disabledColor: themeMaterialColor.withRed(200),
        splashColor: themeMaterialColor.shade50,
        textTheme: ButtonTextTheme.primary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Color(0xaabacd),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData (
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(170, 186, 205, 1),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData (
        style: OutlinedButton.styleFrom(primary: Color(0xaabacd)),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
        ),
      ),
      textTheme: _buildTraderTextTheme(base.textTheme),
      primaryTextTheme: _buildTraderTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTraderTextTheme(base.accentTextTheme),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: lightPrimary,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}

/*class AppThemeConfig {
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
    // primaryTextTheme: TextTheme(
    //
    // ),
    // accentTextTheme: TextTheme(
    //
    // ),
    textTheme: TextTheme(
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
      subtitle2: TextStyle(
        fontFamily: 'RedHatDisplay',
        color: Color.fromRGBO(1, 43, 58, 1),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ), // subtitle
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
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData (
      style: OutlinedButton.styleFrom(
          primary: Color(0xaabacd)
      ),
    ),
    inputDecorationTheme: InputDecorationTheme (
        //labelStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(
            fontFamily: 'RedHatDisplay',
            color: Color.fromRGBO(1, 43, 58, 1),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
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
        subtitle2: TextStyle(
          fontFamily: 'Inter',
          color: Color.fromRGBO(1, 43, 58, 1),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ), // subtitle
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
        button: TextStyle(
          // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
          fontFamily: 'Inter',
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
      ),
    inputDecorationTheme: InputDecorationTheme (
      //labelStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        color: Color.fromRGBO(1, 43, 58, 1),
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );
}*/
