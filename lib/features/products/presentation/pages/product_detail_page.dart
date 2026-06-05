import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:day28/core/analytics/firebase_analytics_service.dart';

import '../../data/models/product.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../../core/auth/auth_notifier.dart';
import '../../../../core/widgets/language_switcher.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          const LanguageSwitcher(),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider).logout();
              authNotifier.setLoggedIn(false);
              if (context.mounted) {
                context.go('/login_page');
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 250,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '₹${product.price}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Text(product.description),
            const SizedBox(height: 20),
            Chip(
              label: Text(
                product.category,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  ref.read(cartProvider.notifier).addToCart(product);

                  await FirebaseAnalyticsService.logAddToCart(
                    productId: product.id.toString(),
                    productName: product.title,
                    category: product.category,
                    price: product.price,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to Cart! 🛒'),
                      duration: Duration(milliseconds: 800),
                    ),
                  );
                },
                child: const Text(
                  'Add To Cart',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
