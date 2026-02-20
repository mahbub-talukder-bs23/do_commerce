import 'package:do_commerce/src/domain/entity/pagination_request_entity.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

import '../entity/product_entity.dart';

class ProductListUseCase {
  final ProductListRepository productListRepository;

  ProductListUseCase({required this.productListRepository});

  Future<List<ProductEntity>> call({
    required bool reset,
    String? search,
    String? category,
  }) async {
    try {
      final requestEntity = PaginationRequestEntity(
        search: search,
        category: category,
        reset: reset,
      );

      return productListRepository.getProductList(requestEntity: requestEntity);
    } catch (e) {
      rethrow;
    }
  }
}
