import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'liquid_colors.dart';

class LiquidTypography {
  static TextTheme get textTheme {
    return GoogleFonts.plusJakartaSansTextTheme().copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        height: 80 / 72,
        letterSpacing: -0.02 * 72,
        color: LiquidColors.onBackground,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        height: 48 / 40,
        letterSpacing: -0.01 * 40,
        color: LiquidColors.onBackground,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 32 / 24,
        letterSpacing: 0.02 * 24,
        color: LiquidColors.onBackground,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 28 / 18,
        letterSpacing: 0.01 * 18,
        color: LiquidColors.onBackground,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        letterSpacing: 0.01 * 16,
        color: LiquidColors.onSurfaceVariant,
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0.05 * 14,
        color: LiquidColors.onBackground,
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        letterSpacing: 0.08 * 12,
        color: LiquidColors.onSurfaceVariant,
      ),
    );
  }
}
