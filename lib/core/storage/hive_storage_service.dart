import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/products/data/models/product.dart';

class HiveStorageService {
  static const String _productsBoxName = 'productsBox';
  static const String _productsKey = 'cached_products';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_productsBoxName);
  }

  static Future<void> saveProducts(List<Product> products) async {
    final box = Hive.box(_productsBoxName);
    final List<Map<String, dynamic>> jsonList = 
        products.map((p) => p.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    await box.put(_productsKey, jsonString);
  }

  static List<Product>? getProducts() {
    final box = Hive.box(_productsBoxName);
    final jsonString = box.get(_productsKey) as String?;
    
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    }
    
    return null;
  }
  
  static Future<void> clearProducts() async {
    final box = Hive.box(_productsBoxName);
    await box.delete(_productsKey);
  }
}
