import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/auth_remote_datasource.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(Dio()),
);

final authProvider = Provider<AuthRemoteDataSource>(
  (ref) => ref.read(authRemoteDataSourceProvider),
);

final logoutProvider = FutureProvider<void>((ref) async {
  final authDataSource = ref.read(authProvider);
  await authDataSource.logout();
});
