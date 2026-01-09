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
