import 'package:flutter/material.dart';

const appOrange = Color(0xffF9B091);
const appPurple = Color(0xff672CBC);
const appGrey = Color(0xff8789A3);
const appGreyDark = Color(0xffA19CC5);
const appPurpleLight = Color(0xffA44AFF);
const appGelapMode = Color(0xff1D2233);
const purpleDark = Color(0xff240F4F);
const purpleBottom = Color(0xff121931);

ThemeData themaTerang = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: appPurpleLight,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: purpleBottom,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: appPurple,
    ),
    bodySmall: TextStyle(
      color: appGelapMode,
    ),
    bodyLarge: TextStyle(
      color: appGelapMode,
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: purpleDark,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: appGelapMode,
    unselectedLabelColor: appGrey,
  ),
);

ThemeData themaGelap = ThemeData(
  brightness: Brightness.dark,
  primaryColor: purpleBottom,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: purpleBottom,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: purpleBottom,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.white,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: appGrey,
  ),
);
