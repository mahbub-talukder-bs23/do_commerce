import 'package:do_commerce/src/domain/entity/product_entity.dart';

class ProductDetailsEntity extends ProductEntity {
  final List<String> tags;
  final String brand;
  final String warrantyInformation;
  final String availabilityStatus;
  final String returnPolicy;
  final List<String> images;
  final List<ReviewEntity> reviews;
  final String qrCodeUrl;

  ProductDetailsEntity({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnail,
    required super.category,
    required super.rating,
    required super.discountPercentage,
    required this.tags,
    required this.brand,
    required this.warrantyInformation,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.images,
    required this.reviews,
    required this.qrCodeUrl,
  });
}

class ReviewEntity {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });
}
