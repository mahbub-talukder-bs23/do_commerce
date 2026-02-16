import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

import '../entity/product_entity.dart';

class ProductListUseCase {
  final ProductListRepository productListRepository;

  ProductListUseCase({required this.productListRepository});

  Future<List<ProductEntity>> call({required bool reset}) async {
    try {
      // if (reset) {
      //   productListRepository.clearProductList();
      // }
      final limit = 10;

      // final currentProducts = productListRepository.productList;
      // final nextPoint = reset ? 0 : currentProducts.length;

      // final currentProducts = productListRepository.productList;
      // final nextPoint = reset ? 1 : (currentProducts.length ~/ limit) + 1;

      // final nextPoint = reset ? null : productListRepository.cursor;

      return productListRepository.getProductList(limit: limit, reset: reset);
    } catch (e) {
      rethrow;
    }
  }
}
