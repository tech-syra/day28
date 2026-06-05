import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/widgets/minimal_glass_container.dart';
import '../../../../core/theme/minimal_colors.dart';

import '../../providers/profile_provider.dart';

class ProfileAvatar extends ConsumerStatefulWidget {
  final double radius;
  final bool isEditable;
  final VoidCallback? onTap;

  const ProfileAvatar({super.key, this.radius = 20, this.isEditable = true, this.onTap});

  @override
  ConsumerState<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends ConsumerState<ProfileAvatar> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        ref.read(profileImageProvider.notifier).setImage(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final _imagePath = ref.watch(profileImageProvider);
    
    final avatar = GestureDetector(
      onTap: widget.onTap ?? (widget.isEditable ? _pickImage : null),
      child: MinimalGlassContainer(
        showBorder: false,
        padding: const EdgeInsets.all(2),
        borderRadius: widget.radius * 2,
        child: CircleAvatar(
          radius: widget.radius,
          backgroundColor: MinimalColors.surface.withValues(alpha: 0.1),
          backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
          child: _imagePath == null
              ? Icon(
                  LucideIcons.user,
                  color: MinimalColors.text,
                  size: widget.radius,
                ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(duration: 2.seconds, color: Colors.white54)
              : null,
        ),
      ).animate().fade().scale(duration: 400.ms, curve: Curves.easeOutBack),
    );

    if (!widget.isEditable) {
      return avatar;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar,
        if (_imagePath != null) ...[
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              ref.read(profileImageProvider.notifier).removeImage();
            },
            child: MinimalGlassContainer(
              showBorder: false,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              borderRadius: 24,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.trash2, size: 16, color: MinimalColors.error),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.removePhoto ?? 'Remove Photo',
                    style: const TextStyle(
                      color: MinimalColors.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fade().scale(duration: 200.ms, curve: Curves.easeOutBack),
        ],
      ],
    );
  }
}
