import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

import '../../providers/product_provider.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../../core/auth/auth_notifier.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../widgets/product_card.dart';
import '../../../../core/theme/minimal_colors.dart';
import '../../../auth/presentation/widgets/profile_avatar.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsProvider);
    final cartState = ref.watch(cartProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF111111), // Deep black-grey background to show off pure white glass
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.appTitle.toUpperCase(), style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ProfileAvatar(
              radius: 18,
              isEditable: false,
              onTap: () => context.push('/profile'),
            ),
          ),
          const SizedBox(width: 8),
          cartState.when(
            data: (cartItems) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.shoppingBag, size: 22, color: Colors.white),
                    onPressed: () => context.push('/cart'),
                  ),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: MinimalColors.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cartItems.length}',
                          style: const TextStyle(
                            color: MinimalColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
            loading: () => IconButton(
              icon: const Icon(LucideIcons.shoppingBag, size: 22, color: Colors.white),
              onPressed: () => context.push('/cart'),
            ),
            error: (_, __) => IconButton(
              icon: const Icon(LucideIcons.shoppingBag, size: 22, color: Colors.white),
              onPressed: () => context.push('/cart'),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Monochrome Fluid Background Blobs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .moveX(end: 150, duration: 10.seconds, curve: Curves.easeInOutSine)
             .moveY(end: 100, duration: 15.seconds, curve: Curves.easeInOutSine),
          ),
          Positioned(
            bottom: -50,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .moveX(end: -100, duration: 12.seconds, curve: Curves.easeInOutSine)
             .moveY(end: -150, duration: 18.seconds, curve: Curves.easeInOutSine),
          ),
          
          // Products List
          productsState.when(
            data: (products) => ListView.builder(
              padding: const EdgeInsets.fromLTRB(24, 120, 24, 40),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index], index: index);
              },
            ),
            loading: () => ListView.builder(
              padding: const EdgeInsets.fromLTRB(24, 120, 24, 40),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      color: Colors.white10,
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                 .shimmer(duration: 1.5.seconds, color: Colors.white24);
              },
            ),
            error: (err, stack) => Center(
              child: Text(
                err.toString(),
                style: const TextStyle(color: MinimalColors.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
