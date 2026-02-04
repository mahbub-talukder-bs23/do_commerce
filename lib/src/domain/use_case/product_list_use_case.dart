import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

import '../entity/product_entity.dart';

class ProductListUseCase {
  final ProductListRepository productListRepository;

  ProductListUseCase({required this.productListRepository});

  Future<List<ProductEntity>> call({required bool reset}) async {
    try {
      // await Future.delayed(const Duration(seconds: 2));
      if (reset) {
        productListRepository.clearProductList();
      }
      final currentProducts = productListRepository.productList;
      final limit = 10;
      final skip = reset ? 0 : currentProducts.length;

      return productListRepository.getProductList(limit: limit, skip: skip);
    } catch (e) {
      rethrow;
    }
  }
}
