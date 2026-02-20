import 'package:dio/dio.dart';
import 'package:do_commerce/src/data/services/local/paginated_data_source/paginated_data_source.dart';

abstract class RestClient {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters});

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> getPaginatedData({
    required PaginationType type,
    int limit = 10,
    int page = 1,
    String? cursor,
    int offset = 0,
    String? search,
    String? category,
  });
}
