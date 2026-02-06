import 'package:do_commerce/src/domain/entity/product_entity.dart';

abstract class ProductListRepository {
  List<ProductEntity> get productList;

  void clearProductList();
  Future<List<ProductEntity>> getProductList({
    required int limit,
    required bool reset,
  });
}
