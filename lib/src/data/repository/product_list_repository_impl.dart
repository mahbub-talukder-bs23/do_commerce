import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/core/pagination/pagination_mixin.dart';
import 'package:do_commerce/src/data/models/product_model.dart';
import 'package:do_commerce/src/data/services/local/paginated_data_source/paginated_data_source.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

class ProductListRepositoryImpl extends ProductListRepository {
  ProductListRepositoryImpl({required this.restClient});

  final RestClient restClient;
  PaginationStrategy<ProductEntity, String?> paginationStrategy =
      CursorPaginationStrategy<ProductEntity>();

  @override
  Future<List<ProductEntity>> getProductList({
    required int limit,
    required bool reset,
  }) async {
    try {
      final nextParam = paginationStrategy.getNextParameter(limit, reset);

      final response = await restClient.getPaginatedData(
        type: PaginationType.cursor,
        limit: limit,
        cursor: nextParam,
      );

      final model = ProductListModel.fromJson(response.data);

      return paginationStrategy.updateAndGetItems(model.products, model.cursor);
    } catch (e, stackTrace) {
      logger.e(e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
