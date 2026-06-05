import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/liquid_colors.dart';
import '../theme/liquid_typography.dart';

class LiquidButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool isLoading;

  const LiquidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  State<LiquidButton> createState() => _LiquidButtonState();
}

class _LiquidButtonState extends State<LiquidButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (!widget.isLoading) widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: _isPressed 
                ? LiquidColors.glassFillHighlight.withOpacity(0.35)
                : _isHovered 
                    ? LiquidColors.glassFillHighlight.withOpacity(0.3) 
                    : LiquidColors.glassFillHighlight,
            borderRadius: BorderRadius.circular(999), // Pill shape
            border: Border.all(
              color: LiquidColors.glassBorder.withOpacity(_isHovered ? 0.4 : 0.25),
              width: 1,
            ),
            boxShadow: _isHovered && !_isPressed
                ? [
                    BoxShadow(
                      color: LiquidColors.primary.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(LiquidColors.primary),
                  ),
                )
              else ...[
                if (widget.icon != null) ...[
                  widget.icon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.text.toUpperCase(),
                  style: LiquidTypography.textTheme.labelMedium?.copyWith(
                    color: LiquidColors.primary,
                  ),
                ),
              ]
            ],
          ),
        ),
      ).animate(target: _isPressed ? 1 : 0).scaleXY(end: 0.96, duration: 100.ms),
    );
  }
}
