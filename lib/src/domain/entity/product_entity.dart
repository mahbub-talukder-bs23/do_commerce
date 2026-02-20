class ProductListEntity {
  final List<ProductEntity> products;

  /// Only for cursor based pagination
  final String? cursor;

  /// Only for page based pagination
  final int? page;

  /// Only for offset based pagination
  final int? offset;

  final int total;

  ProductListEntity({
    required this.products,
    this.cursor,
    this.page,
    this.offset,
    required this.total,
  });
}

class ProductEntity {
  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;
  final String category;
  final num rating;
  final num discountPercentage;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.category,
    required this.rating,
    required this.discountPercentage,
  });

  String getDiscountPrice() {
    return (price - (price * discountPercentage / 100)).toStringAsFixed(2);
  }
}
