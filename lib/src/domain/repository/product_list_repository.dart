import 'package:do_commerce/src/domain/entity/product_entity.dart';

abstract class ProductListRepository {
  List<ProductEntity> get productList;

  /// Only for cursor based pagination
  String? get cursor;

  void clearProductList();
  Future<List<ProductEntity>> getProductList({
    required int limit,
    required dynamic nextPoint,
  });
}
