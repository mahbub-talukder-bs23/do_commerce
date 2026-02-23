// product_list_repository_impl.dart

import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/core/pagination/pagination_strategies.dart';
import 'package:do_commerce/src/data/models/product_model.dart';
import 'package:do_commerce/src/data/services/local/paginated_data_source/paginated_data_source.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:do_commerce/src/domain/entity/pagination_request_entity.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

class ProductListRepositoryImpl extends ProductListRepository {
  ProductListRepositoryImpl({
    required this.restClient,
    required this.paginationStrategy,
  });

  final RestClient restClient;
  final PaginationStrategy<ProductEntity> paginationStrategy;

  final List<ProductEntity> _itemList = [];

  @override
  Future<List<ProductEntity>> getProductList({
    required PaginationRequestEntity requestEntity,
  }) async {
    try {
      final response = await restClient.getPaginatedData(
        type: PaginationType.page,
        limit: paginationStrategy.limit,
        page: paginationStrategy.getNextParam(requestEntity.reset),
        search: requestEntity.search,
        category: requestEntity.category,
      );

      final model = ProductListModel.fromJson(response.data);

      paginationStrategy.updateNextParam(nextParam: model.page);

      return paginationStrategy.getUpdatedItems(
        reset: requestEntity.reset,
        newItems: model.products,
        itemList: _itemList,
      );
    } catch (e, stackTrace) {
      logger.e(e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
