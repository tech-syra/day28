import 'package:flutter/material.dart';
import 'minimal_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MinimalTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme();
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: MinimalColors.background,
      colorScheme: const ColorScheme.light(
        primary: MinimalColors.primary,
        onPrimary: MinimalColors.onPrimary,
        surface: MinimalColors.surface,
        onSurface: MinimalColors.text,
        error: MinimalColors.error,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: MinimalColors.background,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: MinimalColors.primary),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: MinimalColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800, color: MinimalColors.text),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700, color: MinimalColors.text),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: MinimalColors.text),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: MinimalColors.textLight),
      ),
      iconTheme: const IconThemeData(color: MinimalColors.primary),
    );
  }
}
