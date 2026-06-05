import 'package:flutter/material.dart';
import '../theme/liquid_colors.dart';
import '../theme/liquid_typography.dart';

class LiquidChip extends StatelessWidget {
  final String label;
  final Widget? icon;

  const LiquidChip({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: LiquidColors.glassGlow, // 10% white fill, no border
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 6),
          ],
          Text(
            label.toUpperCase(),
            style: LiquidTypography.textTheme.labelSmall?.copyWith(
              color: LiquidColors.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
