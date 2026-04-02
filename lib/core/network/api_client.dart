import 'package:dio/dio.dart';

import 'api_endpoints.dart';

/// Shared Dio wrapper for simple GET requests.
class ApiClient {
  ApiClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiEndpoints.baseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
            ),
          );

  final Dio _dio;

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
    );
    final dynamic data = response.data;
    if (data is Map<String, dynamic>) {
      return data;
    }
    throw const FormatException('Expected JSON object.');
  }
}
