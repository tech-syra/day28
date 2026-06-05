import 'package:dio/dio.dart';

import '../models/login_response.dart';
import '../../../../core/storage/secure_storage_service.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final response = await dio.post(
      'https://fakestoreapi.com/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    return LoginResponse.fromJson(
      response.data,
    );
  }

  Future<void> logout() async {
    // Clear the token from dio headers
    dio.options.headers.remove('Authorization');
    // Delete token from secure storage
    await SecureStorageService().deleteToken();
  }
}