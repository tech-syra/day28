import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/product_provider.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../../core/auth/auth_notifier.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../widgets/product_card.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecom Store'),
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
          cartState.when(
            data: (cartItems) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      context.push('/cart');
                    },
                  ),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${cartItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
            loading: () => IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                context.push('/cart');
              },
            ),
            error: (_, __) => IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                context.push('/cart');
              },
            ),
          ),
        ],
      ),
      body: products.when(
        data: (products) {
          return GridView.builder(
            padding: const EdgeInsets.all(12),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),

            itemCount: products.length,

            itemBuilder: (_, index) {
              return ProductCard(product: products[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}

