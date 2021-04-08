import 'package:flutter/material.dart';

ThemeData themeDark = ThemeData(
  //primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  disabledColor: Colors.white,
  brightness: Brightness.dark,
  accentColor: Color(0xFF3985c0),
  cardColor: Color(0xFF182633),
  primaryColor: Color(0xFF17212b),
  scaffoldBackgroundColor: Color(0xFF131a24),
  canvasColor: Color(0xFF17212b),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Color(0xFF77818d),
    selectedItemColor: Color(0xFF3985c0),
    backgroundColor: Color(0xFF131a24),
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
      color: Color(0xFF3985c0),
      fontSize: 12,
      fontFamily: 'OpenSans',
    ),
    headline1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      fontFamily: 'OpenSans',
    ),
    headline2: TextStyle(
      fontSize: 16,
      fontFamily: 'OpenSans',
    ),
    headline3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF3985c0),
    ),
    headline4: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline5: TextStyle(
      fontSize: 14,
      color: Color(0xFF3985c0),
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
    ),
  ),
);

ThemeData themeLight = ThemeData(
  //primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  disabledColor: Colors.green,
  //brightness: Brightness.light,
  //primarySwatch: Color(0xFF3985c0),
  primaryIconTheme: IconThemeData(
    color: Color(0xFF3985c0),
  ),
  primaryTextTheme: TextTheme(
    headline6: TextStyle(color: Color(0xFF3985c0)),
  ),
  accentColor: Color(0xFF3985c0),
  cardColor: Color(0xFFffffff),
  primaryColor: Color(0xFFffffff),
  scaffoldBackgroundColor: Color(0xFFedeef0),
  canvasColor: Color(0xFFffffff),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Color(0xFF77818d),
    selectedItemColor: Color(0xFF3985c0),
    backgroundColor: Color(0xFFedeef0),
  ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
      color: Color(0xFF3985c0),
      fontSize: 12,
      fontFamily: 'OpenSans',
    ),
    headline1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      fontFamily: 'OpenSans',
    ),
    headline2: TextStyle(
      fontSize: 16,
      fontFamily: 'OpenSans',
    ),
    headline3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF3985c0),
    ),
    headline4: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xFF77818d),
    ),
    headline5: TextStyle(
      fontSize: 14,
      color: Color(0xFF3985c0),
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
    ),
  ),
);
