import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F46E5),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF4F6FB),
      useMaterial3: true,
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'ProductSans',
      ),
      fontFamily: 'ProductSans',
    );
  }
}

