import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/cart_item.dart';
import '../../products/data/models/product.dart';
import 'cart_local_data_source_provider.dart';

part 'cart_provider.g.dart';

@riverpod
class Cart extends _$Cart {

  Future<void> _saveCart() async {
    final dataSource = ref.read(
      cartLocalDataSourceProvider,
    );
    final currentItems = state.valueOrNull ?? [];
    await dataSource.saveCart(currentItems);
  }

  @override
  Future<List<CartItem>> build() async {
    final dataSource = ref.read(
      cartLocalDataSourceProvider,
    );
    return await dataSource.loadCart();
  }

  void addToCart(Product product) {
    state = AsyncValue.data(
      _addToCartLogic(
        state.valueOrNull ?? [],
        product,
      ),
    );
    _saveCart();
  }

  List<CartItem> _addToCartLogic(
    List<CartItem> items,
    Product product,
  ) {
    final index = items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      return [
        for (final item in items)
          if (item.product.id == product.id)
            item.copyWith(
              quantity: item.quantity + 1,
            )
          else
            item,
      ];
    } else {
      return [
        ...items,
        CartItem(
          product: product,
          quantity: 1,
        ),
      ];
    }
  }

  void removeFromCart(int productId) {
    state = AsyncValue.data(
      (state.valueOrNull ?? [])
          .where(
            (item) => item.product.id != productId,
          )
          .toList(),
    );
    _saveCart();
  }

  void decreaseQuantity(int productId) {
    final items = state.valueOrNull ?? [];
    final updatedCart = [
      for (final item in items)
        if (item.product.id == productId)
          if (item.quantity > 1)
            item.copyWith(quantity: item.quantity - 1)
          else
            null
        else
          item,
    ].whereType<CartItem>().toList();

    state = AsyncValue.data(updatedCart);
    _saveCart();
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }
    
    final items = state.valueOrNull ?? [];
    final updatedCart = [
      for (final item in items)
        if (item.product.id == productId)
          item.copyWith(quantity: newQuantity)
        else
          item,
    ];

    state = AsyncValue.data(updatedCart);
    _saveCart();
  }

  void clearCart() {
    state = const AsyncValue.data([]);
    _saveCart();
  }
}


