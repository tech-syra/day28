import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/dio_provider.dart';
import '../data/datasource/product_remote_datasource.dart';
import '../data/models/product.dart';
import '../data/repositories/product_repository_impl.dart';

part 'product_provider.g.dart';

@riverpod
ProductRemoteDataSource productRemoteDataSource(
  ProductRemoteDataSourceRef ref,
) {
  final dio = ref.watch(dioProvider);

  return ProductRemoteDataSource(dio);
}

@riverpod
ProductRepositoryImpl productRepository(
  ProductRepositoryRef ref,
) {
  return ProductRepositoryImpl(
    ref.watch(productRemoteDataSourceProvider),
  );
}

@riverpod
Future<List<Product>> products(
  ProductsRef ref,
) {
  return ref.watch(
    productRepositoryProvider,
  ).getProducts();
}