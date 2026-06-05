import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/cart_local_data_source.dart';

final cartLocalDataSourceProvider = Provider(
  (ref) => CartLocalDataSource(
    storage: const FlutterSecureStorage(),
  ),
);
