import 'dart:math';

import 'package:do_commerce/src/core/di/di.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_list_provider.g.dart';

@riverpod
class ProductList extends _$ProductList {
  @override
  Future<List<ProductEntity>> build() async {
    await Future.delayed(const Duration(seconds: 2));

    final data = ref.read(productListUseCaseProvider).call(reset: false);

    return [
      ProductEntity(
        id: 1,
        title: 'Product 1',
        description: 'Description 1',
        price: 100,
        discountPercentage: 10,
        rating: 4.5,

        category: 'Category 1',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 2,
        title: 'Product 2',
        description: 'Description 2',
        price: 200,
        discountPercentage: 20,
        rating: 4.5,

        category: 'Category 2',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 1,
        title: 'Product 1',
        description: 'Description 1',
        price: 100,
        discountPercentage: 10,
        rating: 4.5,

        category: 'Category 1',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 2,
        title: 'Product 2',
        description: 'Description 2',
        price: 200,
        discountPercentage: 20,
        rating: 4.5,

        category: 'Category 2',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 1,
        title: 'Product 1',
        description: 'Description 1',
        price: 100,
        discountPercentage: 10,
        rating: 4.5,

        category: 'Category 1',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 2,
        title: 'Product 2',
        description: 'Description 2',
        price: 200,
        discountPercentage: 20,
        rating: 4.5,

        category: 'Category 2',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 1,
        title: 'Product 1',
        description: 'Description 1',
        price: 100,
        discountPercentage: 10,
        rating: 4.5,

        category: 'Category 1',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 2,
        title: 'Product 2',
        description: 'Description 2',
        price: 200,
        discountPercentage: 20,
        rating: 4.5,

        category: 'Category 2',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 1,
        title: 'Product 1',
        description: 'Description 1',
        price: 100,
        discountPercentage: 10,
        rating: 4.5,

        category: 'Category 1',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
      ProductEntity(
        id: 2,
        title: 'Product 2',
        description: 'Description 2',
        price: 200,
        discountPercentage: 20,
        rating: 4.5,

        category: 'Category 2',
        thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ),
    ];
  }

  /* 
  override
  Future<List<ProductEntity>> build() async {
    final response = await ref
        .read(restClientProvider)
        .get(ApiEndPoints.products, queryParameters: {'limit': 10, 'skip': 0});

    final list = response.data['products'];

    final newProductList = List<ProductEntity>.from(
      list.map((x) => ProductModel.fromJson(x)),
    );

    return newProductList;
  }  
  */

  // Future<void> loadProductList({bool reset = false}) async {
  //   state = await AsyncValue.guard(() async {
  //     return await ref.read(productListUseCaseProvider).call(reset: reset);
  //   });
  // }
}

@riverpod
class GetData extends _$GetData {
  @override
  Future<int> build() async {
    await Future.delayed(const Duration(seconds: 2));
    return Random().nextInt(100);
  }
}
