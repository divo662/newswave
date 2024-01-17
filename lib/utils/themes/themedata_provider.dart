import 'package:flutter/material.dart';
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: Colors.blue, // Set primary color to blue
    secondary: Colors.orange,
    background: Colors.black,
    brightness: Brightness.dark,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
    ),
    // Add more text styles as needed
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue, // Set button background color to blue
    ),
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Colors.blue, // Set primary color to blue
    secondary: Colors.orange,
    background: Colors.white,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
    ),
    // Add more text styles as needed
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue, // Set button background color to blue
    ),
  ),
);
