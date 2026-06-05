import '../../../../core/storage/hive_storage_service.dart';
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
  Future<List<Product>> getProducts() async {
    // 1. Check local Hive storage first
    final localProducts = HiveStorageService.getProducts();
    if (localProducts != null && localProducts.isNotEmpty) {
      return localProducts;
    }

    // 2. If no local data, fetch from API
    final remoteProducts = await remoteDataSource.getProducts();

    // 3. Save to Hive
    await HiveStorageService.saveProducts(remoteProducts);

    return remoteProducts;
  }
}