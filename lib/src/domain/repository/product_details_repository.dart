import 'package:do_commerce/src/domain/entity/product_details_entity.dart';

abstract class ProductDetailsRepository {
  Future<ProductDetailsEntity> getProductDetails(int id);
}
