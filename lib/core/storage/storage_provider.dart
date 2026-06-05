import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secure_storage_service.dart';

part 'storage_provider.g.dart';

@riverpod
SecureStorageService storageService(
  StorageServiceRef ref,
) {
  return SecureStorageService();
}