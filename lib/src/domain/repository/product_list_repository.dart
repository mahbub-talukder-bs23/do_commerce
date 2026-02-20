import 'package:do_commerce/src/domain/entity/pagination_request_entity.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';

abstract class ProductListRepository {
  Future<List<ProductEntity>> getProductList({
    required PaginationRequestEntity requestEntity,
  });
}
