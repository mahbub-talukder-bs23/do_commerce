import 'dart:ffi';

import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/core/pagination/pagination_mixin.dart';
import 'package:do_commerce/src/data/models/product_model.dart';
import 'package:do_commerce/src/data/services/local/paginated_data_source/paginated_data_source.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/domain/repository/product_list_repository.dart';

import '../../domain/entity/pagination_request_entity.dart';

class ProductListRepositoryImpl extends ProductListRepository {
  ProductListRepositoryImpl({
    required this.restClient,
    required this.paginationStrategy,
  });

  final RestClient restClient;
  final PaginationStrategy<ProductEntity> paginationStrategy;

  final List<ProductEntity> _itemList = [];

  int _page = 1;
  // int _offset = 0;
  // String? _cursor;

  bool _hasMore = true;

  @override
  Future<List<ProductEntity>> getProductList({
    required PaginationRequestEntity requestEntity,
  }) async {
    try {
      if (!(requestEntity.reset || _hasMore)) return _itemList;

      final response = await restClient.getPaginatedData(
        type: PaginationType.page,
        limit: requestEntity.limit,
        page: requestEntity.reset ? 1 : _page,
        search: requestEntity.search,
        category: requestEntity.category,
      );

      final model = ProductListModel.fromJson(response.data);

      final updatedItems = paginationStrategy.getUpdatedItems(
        reset: requestEntity.reset,
        newItems: model.products,
        itemList: _itemList,
        updateNextParam: () {
          _page = (model.page ?? 1) + 1;
          _hasMore = paginationStrategy.hasMore(
            reset: requestEntity.reset,
            total: model.total,
            currentLength: _itemList.length,
          );
        },
      );

      return updatedItems;
    } catch (e, stackTrace) {
      logger.e(e, stackTrace: stackTrace);
      rethrow;
    }
  }
}


// class ProductListRepositoryImpl extends ProductListRepository {
//   ProductListRepositoryImpl({required this.restClient});

//   final RestClient restClient;

//   PaginationStrategy<ProductEntity, int> paginationStrategy =
//       OffsetPaginationStrategy<ProductEntity>();

//   @override
//   Future<List<ProductEntity>> getProductList({
//     required int limit,
//     required bool reset,
//   }) async {
//     try {
//       final nextParam = paginationStrategy.getNextParameter(reset: reset);

//       final response = await restClient.getPaginatedData(
//         type: PaginationType.skip,
//         limit: limit,
//         skip: nextParam,
//       );

//       final model = ProductListModel.fromJson(response.data);

//       return paginationStrategy.fetchUpdatedItems(items: model.products);
//     } catch (e, stackTrace) {
//       logger.e(e, stackTrace: stackTrace);
//       rethrow;
//     }
//   }
// }


// class ProductListRepositoryImpl extends ProductListRepository {
//   ProductListRepositoryImpl({required this.restClient});

//   final RestClient restClient;

//   PaginationStrategy<ProductEntity, String?> paginationStrategy =
//       CursorPaginationStrategy<ProductEntity>();

//   @override
//   Future<List<ProductEntity>> getProductList({
//     required int limit,
//     required bool reset,
//   }) async {
//     try {
//       final nextParam = paginationStrategy.getNextParameter(reset: reset);

//       final response = await restClient.getPaginatedData(
//         type: PaginationType.cursor,
//         limit: limit,
//         cursor: nextParam,
//       );

//       final model = ProductListModel.fromJson(response.data);

//       return paginationStrategy.fetchUpdatedItems(items: model.products, nextParameter: model.cursor);
//     } catch (e, stackTrace) {
//       logger.e(e, stackTrace: stackTrace);
//       rethrow;
//     }
//   }
// }
