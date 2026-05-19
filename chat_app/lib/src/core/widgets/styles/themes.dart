import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'OpenSans',

    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFce7e5a),
      brightness: Brightness.light,
    ).copyWith(surface: Colors.white),

    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      foregroundColor: Color(0xFF64748B),
      backgroundColor: Colors.white,
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: Color(0xFF64748b)),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'OpenSans',

    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFd79779),
      brightness: Brightness.dark,
    ).copyWith(surface: Color(0xFF121212), onSurface: Colors.white),

    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      foregroundColor: Color(0xFFA1A1AA),
      backgroundColor: Color(0xFF121212),
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: Color(0xFFA1A1AA)),
  );
}
