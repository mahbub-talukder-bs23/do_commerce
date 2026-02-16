import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/core/pagination/pagination_mixin.dart';
import 'package:do_commerce/src/data/models/product_model.dart';
import 'package:do_commerce/src/data/services/local/paginated_data_source/paginated_data_source.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

class ProductListRepositoryImpl extends ProductListRepository
    with
        PaginationMixin<ProductEntity>,
        PagePaginationStrategyMixin<ProductEntity> {
  ProductListRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  List<ProductEntity> get productList => itemList;

  @override
  void clearProductList() {
    clearItemList();
  }

  @override
  Future<List<ProductEntity>> getProductList({
    required int limit,
    required bool reset,
  }) async {
    try {
      if (reset) {
        clearItemList();
      }

      final response = await restClient.getPaginatedData(
        type: PaginationType.page,
        limit: limit,
        page: calculatePage(limit, reset),
      );

      final result = ProductListModel.fromJson(response.data);

      addItems(result.products);

      return productList;
    } catch (e, stackTrace) {
      logger.e(e, stackTrace: stackTrace);
      throw Exception(e.toString());
    }
  }
}
