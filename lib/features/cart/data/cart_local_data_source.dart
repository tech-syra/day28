import 'dart:convert';import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/cart_item.dart';

class CartLocalDataSource {
  static const String _cartKey = 'cart_items';

  final FlutterSecureStorage storage;

  CartLocalDataSource({
    required this.storage,
  });

  Future<List<CartItem>> loadCart() async {
    try {
      final jsonString = await storage.read(
        key: _cartKey,
      );

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error loading cart: $e');
      return [];
    }
  }

  Future<void> saveCart(List<CartItem> cartItems) async {
    try {
      final jsonList = cartItems
          .map((item) => item.toJson())
          .toList();
      final jsonString = jsonEncode(jsonList);

      await storage.write(
        key: _cartKey,
        value: jsonString,
      );
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      await storage.delete(key: _cartKey);
    } catch (e) {
      debugPrint('Error clearing cart: $e');
    }
  }
}
