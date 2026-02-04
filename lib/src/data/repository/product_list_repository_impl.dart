import 'package:dio/dio.dart';
import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/data/models/product_model.dart';
import 'package:do_commerce/src/data/services/local/paginated_data_source/paginated_data_source.dart';
import 'package:do_commerce/src/data/services/network/api_end_points.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';
import 'package:logger/logger.dart';

class ProductListRepositoryImpl implements ProductListRepository {
  ProductListRepositoryImpl({required this.restClient});

  final RestClient restClient;
  final _productList = <ProductEntity>[];
  String? _cursor;

  @override
  Future<List<ProductEntity>> getProductList({
    required int limit,
    required dynamic nextPoint,
  }) async {
    try {
      final response = await restClient.getPaginatedData(
        type: PaginationType.cursor,
        limit: limit,
        cursor: nextPoint as String?,
      );

      // final response = await restClient.get(
      //   ApiEndPoints.products,
      //   queryParameters: {'limit': limit, 'skip': skip},
      // );

      // final list = response.data['products'];

      // final newProductList = List<ProductModel>.from(
      //   list.map((x) => ProductModel.fromJson(x)),
      // );

      final result = ProductListModel.fromJson(response.data);

      /// Only for cursor based pagination
      _cursor = result.cursor;

      _productList.addAll(result.products);

      return _productList.toList();
    } catch (e, stackTrace) {
      logger.e(e, stackTrace: stackTrace);

      throw Exception(e.toString());
    }
  }

  @override
  List<ProductEntity> get productList => _productList.toList();

  @override
  void clearProductList() {
    _productList.clear();
    _cursor = null;
  }

  @override
  String? get cursor => _cursor;
}
