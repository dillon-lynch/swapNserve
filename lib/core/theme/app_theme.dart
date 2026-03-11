import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(
          0xFF2E7D32,
        ), // green — community / sustainability
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );

    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: base.appBarTheme.copyWith(centerTitle: true),
    );
  }

  static ThemeData get dark {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E7D32),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );

    return base.copyWith(textTheme: GoogleFonts.interTextTheme(base.textTheme));
  }
}
