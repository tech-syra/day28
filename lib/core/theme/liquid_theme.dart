import 'package:flutter/material.dart';
import 'liquid_colors.dart';
import 'liquid_typography.dart';

class LiquidTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: LiquidColors.background,
      colorScheme: const ColorScheme.dark(
        primary: LiquidColors.primary,
        onPrimary: LiquidColors.onPrimary,
        secondary: LiquidColors.secondary,
        onSecondary: LiquidColors.onSecondary,
        surface: LiquidColors.surface,
        onSurface: LiquidColors.onSurface,
        error: LiquidColors.error,
        onError: LiquidColors.onError,
        background: LiquidColors.background,
        onBackground: LiquidColors.onBackground,
      ),
      textTheme: LiquidTypography.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: LiquidTypography.textTheme.headlineMedium,
        iconTheme: const IconThemeData(color: LiquidColors.onBackground),
      ),
    );
  }
}
