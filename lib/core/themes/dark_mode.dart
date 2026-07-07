import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade800,
    tertiary: Colors.grey.shade600,
    inversePrimary: Colors.grey.shade300,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
);
