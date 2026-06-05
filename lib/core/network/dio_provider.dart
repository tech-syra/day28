import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dio_client.dart';

part 'dio_provider.g.dart';

@riverpod
 Dio dio(DioRef ref) {
  return DioClient().dio;
}