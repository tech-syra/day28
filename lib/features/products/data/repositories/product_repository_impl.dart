import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_datasource.dart';
import '../models/product.dart';

class ProductRepositoryImpl
    implements ProductRepository {

  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<List<Product>> getProducts() {
    return remoteDataSource.getProducts();
  }
}