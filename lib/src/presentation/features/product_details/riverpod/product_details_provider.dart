import 'package:do_commerce/src/core/di/di.dart';
import 'package:do_commerce/src/domain/entity/product_details_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_details_provider.g.dart';

@riverpod
Future<ProductDetailsEntity> productDetails(Ref ref, int id) {
  return ref.watch(productDetailsUseCaseProvider).call(id);
}
