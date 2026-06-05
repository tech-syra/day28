import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/cart_provider.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../../core/auth/auth_notifier.dart';
import '../../../../core/widgets/language_switcher.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛒 Cart'),
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
      body: cartState.when(
        data: (cartItems) {
          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final totalPrice = cartItems.fold<double>(
            0,
            (sum, item) => sum + (item.product.price * item.quantity),
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    final product = cartItem.product;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Image.network(
                              product.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 2,
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '₹${product.price}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        ref
                                            .read(cartProvider
                                                .notifier)
                                            .decreaseQuantity(
                                              product.id,
                                            );
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                      ),
                                      iconSize: 20,
                                    ),
                                    Text(
                                      '${cartItem.quantity}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        ref
                                            .read(cartProvider
                                                .notifier)
                                            .addToCart(product);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                      ),
                                      iconSize: 20,
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(cartProvider
                                            .notifier)
                                        .removeFromCart(
                                          product.id,
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  iconSize: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
