import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: const Color(0xfff6f6f6),
    primary: Colors.blue.shade500,
    secondary: Colors.blue.shade400,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: const Color(0xff121212),
    primary: Colors.blue.shade800,
    secondary: Colors.blue.shade700,
  ),
);
