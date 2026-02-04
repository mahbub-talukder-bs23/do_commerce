import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

import '../entity/product_entity.dart';

class ProductListUseCase extends CursorStrategy {
  final ProductListRepository productListRepository;

  ProductListUseCase({required this.productListRepository});

  Future<List<ProductEntity>> call({required bool reset}) async {
    try {
      if (reset) {
        productListRepository.clearProductList();
      }
      final limit = 10;

      // final currentProducts = productListRepository.productList;
      // final nextPoint = reset ? 0 : currentProducts.length;

      // final currentProducts = productListRepository.productList;
      // final nextPoint = reset ? 1 : (currentProducts.length ~/ limit) + 1;

      // final nextPoint = reset ? null : productListRepository.cursor;

      return productListRepository.getProductList(
        limit: limit,
        nextPoint: calculate(productListRepository.cursor, reset),
      );
    } catch (e) {
      rethrow;
    }
  }
}

abstract class PaginationStrategy<TOutput, TInput, TReset> {
  TOutput calculate(TInput input, TReset reset);
}

class OffsetStrategy implements PaginationStrategy<int, int, bool> {
  @override
  int calculate(int length, bool reset) => reset ? 0 : length;
}

class PageStrategy implements PaginationStrategy<int, int, bool> {
  final int limit;
  PageStrategy(this.limit);

  @override
  int calculate(int length, bool reset) => reset ? 1 : (length ~/ limit) + 1;
}

class CursorStrategy implements PaginationStrategy<String?, String?, bool> {
  @override
  String? calculate(String? currentCursor, bool reset) => currentCursor;
}
