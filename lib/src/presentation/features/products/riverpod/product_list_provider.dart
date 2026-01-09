import 'package:do_commerce/src/core/di/di.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_list_provider.g.dart';

@riverpod
Future<List<ProductEntity>> productList(Ref ref, {bool reset = false}) async {
  final products = await ref
      .read(productListUseCaseProvider)
      .call(reset: reset);

  return products;
}
