import 'package:dio/dio.dart';

import '../models/product.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<List<Product>> getProducts() async {
    final response = await dio.get('/products');

    return (response.data as List)
        .map(
          (json) => Product.fromJson(json),
        )
        .toList();
  }
}