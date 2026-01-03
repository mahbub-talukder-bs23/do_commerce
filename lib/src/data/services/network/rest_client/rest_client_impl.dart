import 'package:dio/dio.dart';
import 'package:do_commerce/src/data/services/local/secure_storage.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';

import '../custom_interceptor.dart';

import '../api_end_points.dart';

class RestClientImpl implements RestClient {
  static final RestClientImpl _instance = RestClientImpl._internal();
  late Dio _dio;

  factory RestClientImpl() {
    return _instance;
  }

  RestClientImpl._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
    _dio.interceptors.add(LoggingInterceptor());
  }

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final String? accessToken = await SecureStorage().read('access_token');

      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Failed with status code ${e.response!.statusCode}: ${e.response!.statusMessage}',
        );
      } else {
        throw Exception('Failed to connect: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    }
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    }
  }

  @override
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    }
  }
}
