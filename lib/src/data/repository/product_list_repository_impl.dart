// product_list_repository_impl.dart

import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/core/pagination/pagination_mixin.dart';
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
  int _page = 1;

  @override
  Future<List<ProductEntity>> getProductList({
    required PaginationRequestEntity requestEntity,
  }) async {
    try {
      final response = await restClient.getPaginatedData(
        type: PaginationType.page,
        limit: requestEntity.limit,
        page: requestEntity.reset ? 1 : _page,
        search: requestEntity.search,
        category: requestEntity.category,
      );

      final model = ProductListModel.fromJson(response.data);

      return paginationStrategy.getUpdatedItems(
        reset: requestEntity.reset,
        newItems: model.products,
        itemList: _itemList,
        updateNextParam: () {
          _page = (model.page ?? 1) + 1;
        },
      );
    } catch (e, stackTrace) {
      logger.e(e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
