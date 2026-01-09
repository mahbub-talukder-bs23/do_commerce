import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/data/models/product_model.dart';
import 'package:do_commerce/src/data/services/network/api_end_points.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';
import 'package:logger/logger.dart';

class ProductListRepositoryImpl implements ProductListRepository {
  ProductListRepositoryImpl({required this.restClient});

  final RestClient restClient;
  final _productList = <ProductEntity>[];

  @override
  Future<List<ProductEntity>> getProductList({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await restClient.get(
        ApiEndPoints.products,
        queryParameters: {'limit': limit, 'skip': skip},
      );

      final list = response.data['products'];

      final newProductList = List<ProductModel>.from(
        list.map((x) => ProductModel.fromJson(x)),
      );

      _productList.addAll(newProductList);

      return _productList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  List<ProductEntity> get productList => _productList;

  @override
  void clearProductList() {
    _productList.clear();
  }
}
