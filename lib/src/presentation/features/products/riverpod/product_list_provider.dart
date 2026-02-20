import 'package:do_commerce/src/core/di/di.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_list_provider.g.dart';

@riverpod
class ProductList extends _$ProductList {
  String? _search;
  String? _category;

  @override
  FutureOr<List<ProductEntity>> build() async {
    return ref
        .read(productListUseCaseProvider)
        .call(reset: true, search: _search, category: _category);
  }

  Future<void> loadMoreProduct({bool reset = false}) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref
          .read(productListUseCaseProvider)
          .call(reset: reset, search: _search, category: _category);
    });
  }

  Future<void> updateSearch(String? search) async {
    _search = search;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref
          .read(productListUseCaseProvider)
          .call(reset: true, search: _search, category: _category);
    });
  }

  Future<void> updateCategory(String? category) async {
    _category = category;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref
          .read(productListUseCaseProvider)
          .call(reset: true, search: _search, category: _category);
    });
  }
}
