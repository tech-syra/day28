import 'dart:ui';
import 'package:flutter/material.dart';

class MinimalGlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color color;
  final bool showBorder;

  const MinimalGlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 24.0,
    this.color = const Color(0x66FFFFFF), // More transparent for better refraction
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), // Reduced blur for massive performance boost during scroll
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.5),
                Colors.white.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.05),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.transparent), // Removing flat border
          ),
          child: Container(
            // Inner shadow to simulate volumetric thickness
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: showBorder ? Border.all(
                color: Colors.white.withValues(alpha: 0.7),
                width: 1.5,
                strokeAlign: BorderSide.strokeAlignInside,
              ) : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
