import 'dart:ui';
import 'package:flutter/material.dart';

class CrystalGlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool showBorder;

  const CrystalGlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 24.0,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    // A true crystal glass effect specifically tailored for Cart Screen
    // 1. High blur BackdropFilter
    // 2. A shiny 3D gradient border (simulated with a padded container)
    // 3. A translucent gradient fill
    // 4. Up and Down Shadows
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // Down side shadow (deep black)
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
          // Up side shadow (light glow)
          if (showBorder)
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -8),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Reduced blur for smooth 60fps scrolling
          child: Container(
            // Gradient Border Wrapper
            padding: showBorder ? const EdgeInsets.all(1.5) : EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: showBorder ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.9), // Bright top-left shine
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.0), // Transparent middle
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.6), // Secondary bottom-right glare
                ],
                stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
              ) : null,
            ),
            child: Container(
              // Glass Fill
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(showBorder ? borderRadius - 1.5 : borderRadius),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.35),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
