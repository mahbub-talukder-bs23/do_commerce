import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

import '../entity/product_entity.dart';

class ProductListUseCase {
  ProductListUseCase({required this.productListRepository});

  final ProductListRepository productListRepository;

  Future<List<ProductEntity>> call({required bool reset}) async {
    try {
      if (reset) {
        productListRepository.clearProductList();
      }
      final currentProducts = productListRepository.productList;
      final limit = 10;
      final skip = reset ? 0 : currentProducts.length;

      return await productListRepository.getProductList(
        limit: limit,
        skip: skip,
      );
    } catch (e) {
      rethrow;
    }
  }
}
