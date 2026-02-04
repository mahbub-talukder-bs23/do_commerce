import 'package:dio/dio.dart';
import 'package:do_commerce/src/data/services/local/paginated_data_source/paginated_data_source.dart';
import 'package:do_commerce/src/data/services/local/secure_storage.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/logger/logger.dart';
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
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
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
        logger.e(e.response!.data);
        throw Exception(
          'Failed with status code ${e.response!.statusCode}: ${e.response!.statusMessage}',
        );
      } else {
        logger.e(e.message);
        throw Exception('Failed to connect: ${e.message}');
      }
    } catch (e) {
      logger.e(e);
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
      logger.e(e.response?.data);
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
      logger.e(e.response?.data);
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
      logger.e(e.response?.data);
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
      logger.e(e.response?.data);
      throw Exception(e.response?.data['message']);
    }
  }

  @override
  Future<Response> getPaginatedData({
    required PaginationType type,
    int limit = 10,
    int page = 1,
    String? cursor,
    int skip = 0,
  }) async {
    final data = await switch (type) {
      PaginationType.page => PaginatedDataSource.getDataOnPageLimit(
        limit: limit,
        page: page,
      ),
      PaginationType.skip => PaginatedDataSource.getDataOnSkipLimit(
        limit: limit,
        skip: skip,
      ),
      PaginationType.cursor => PaginatedDataSource.getDataOnCursorLimit(
        limit: limit,
        cursor: cursor,
      ),
    };

    logger.i(data);

    return Response(
      data: data,
      requestOptions: RequestOptions(path: ''),
    );
  }
}
