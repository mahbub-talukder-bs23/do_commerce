import 'package:do_commerce/src/domain/entity/product_entity.dart';

class ProductListModel extends ProductListEntity {
  ProductListModel({
    required super.products,
    required super.cursor,
    required super.page,
    required super.offset,
    required super.total,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      products: List<ProductModel>.from(
        json['products'].map((x) => ProductModel.fromJson(x)),
      ),
      cursor: json['cursor'],
      page: json['page'],
      offset: json['skip'],
      total: json['total'],
    );
  }
}

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnail,
    required super.category,
    required super.rating,
    required super.discountPercentage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      category: json['category'],
      rating: json['rating'],
      discountPercentage: json['discountPercentage'],
    );
  }
}
