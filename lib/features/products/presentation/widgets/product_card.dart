import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_animate/flutter_animate.dart';
import '../../data/models/product.dart';
import '../../../../core/theme/minimal_colors.dart';
import '../../../../core/widgets/minimal_glass_container.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  const ProductCard({
    super.key,
    required this.product,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/product',
          extra: product,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MinimalColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Stack(
              children: [
                // Product Image with Hero Animation
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80, top: 24, left: 24, right: 24),
                    child: Hero(
                      tag: 'product_image_${product.id}',
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                       .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOut),
                    ),
                  ),
                ),
                // Glass Text Container at the bottom
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MinimalGlassContainer(
                    borderRadius: 0,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.title.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.category.toUpperCase(),
                                style: const TextStyle(
                                  color: MinimalColors.textLight,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            color: MinimalColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate(delay: (index * 100).ms).fadeIn(duration: 400.ms, curve: Curves.easeOut).slideY(begin: 0.05, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}