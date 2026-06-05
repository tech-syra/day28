import 'package:flutter/material.dart';
import '../theme/minimal_colors.dart';

class MinimalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const MinimalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: MinimalColors.primary,
          foregroundColor: MinimalColors.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Sharp corners for minimal look
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: MinimalColors.onPrimary,
                ),
              )
            : Text(
                text.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
      ),
    );
  }
}
