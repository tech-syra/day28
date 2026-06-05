import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:day28/core/analytics/firebase_analytics_service.dart';
import '../../data/models/product.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../../core/widgets/language_switcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/minimal_colors.dart';
import '../../../../core/widgets/minimal_button.dart';
import '../../../../core/widgets/minimal_glass_container.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseAnalyticsService.logProductView(
        productId: widget.product.id.toString(),
        productName: widget.product.title,
        category: widget.product.category,
        price: widget.product.price,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MinimalColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: MinimalColors.primary),
          onPressed: () => context.pop(),
        ),
        actions: [
          const LanguageSwitcher(),
          IconButton(
            icon: const Icon(LucideIcons.shoppingBag, color: MinimalColors.primary),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Container(
              color: MinimalColors.surface,
              padding: const EdgeInsets.only(top: 100, bottom: 40),
              child: Hero(
                tag: 'product_image_${product.id}',
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MinimalGlassContainer(
              borderRadius: 32,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: MinimalColors.borderDark),
                    ),
                    child: Text(
                      product.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price}', 
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: MinimalColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: MinimalColors.text,
                    ),
                  ),
                  const SizedBox(height: 24),
                  MinimalButton(
                    text: l10n.addToCart,
                    onPressed: () async {
                      ref.read(cartProvider.notifier).addToCart(product);

                      await FirebaseAnalyticsService.logAddToCart(
                        productId: product.id.toString(),
                        productName: product.title,
                        category: product.category,
                        price: product.price,
                      );

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.success),
                            backgroundColor: MinimalColors.primary,
                            duration: const Duration(milliseconds: 1500),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.2, delay: 200.ms, duration: 600.ms, curve: Curves.easeOutQuint).fade(delay: 200.ms, duration: 600.ms),
          ),
        ],
      ),
    );
  }
}
