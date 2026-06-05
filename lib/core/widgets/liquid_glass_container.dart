import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/liquid_colors.dart';

class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final bool isForeground;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.all(24.0),
    this.width,
    this.height,
    this.isForeground = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: isForeground ? LiquidColors.glassFillHighlight : LiquidColors.glassFill,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: LiquidColors.glassBorder,
              width: 1.0,
            ),
            // Inner glow effect
            boxShadow: [
              BoxShadow(
                color: LiquidColors.glassGlow,
                offset: const Offset(-2, -2),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
