import 'package:flutter/material.dart';
import '../theme/liquid_colors.dart';
import '../theme/liquid_typography.dart';

class LiquidTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const LiquidTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: LiquidTypography.textTheme.bodyMedium?.copyWith(
        color: LiquidColors.onBackground,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: LiquidTypography.textTheme.bodyMedium?.copyWith(
          color: LiquidColors.onSurfaceVariant.withOpacity(0.5),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: LiquidColors.glassBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: LiquidColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: LiquidColors.error,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: LiquidColors.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
