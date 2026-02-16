import 'package:dart_mappable/dart_mappable.dart';
import 'package:do_commerce/src/domain/entity/product_details_entity.dart';

part 'product_details_model.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.decode)
class ProductDetailsModel extends ProductDetailsEntity
    with ProductDetailsModelMappable {
  ProductDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnail,
    required super.category,
    required super.rating,
    required super.discountPercentage,
    required super.tags,
    required super.brand,
    required super.warrantyInformation,
    required super.availabilityStatus,
    required super.returnPolicy,
    required super.images,
    required MetaModel meta,
    required List<ReviewModel> reviews,
  }) : super(qrCodeUrl: meta.qrCode, reviews: reviews);

  // factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
  //   return ProductDetailsModel(
  //     id: json['id'] ?? 0,
  //     title: json['title'] ?? '',
  //     description: json['description'] ?? '',
  //     price: json['price'] ?? 0.0,
  //     thumbnail: json['thumbnail'] ?? '',
  //     category: json['category'] ?? '',
  //     rating: json['rating'] ?? 0.0,
  //     discountPercentage: json['discountPercentage'] ?? 0.0,
  //     tags: List<String>.from(json['tags'] ?? []),
  //     brand: json['brand'] ?? '',
  //     warrantyInformation: json['warrantyInformation'] ?? '',
  //     availabilityStatus: json['availabilityStatus'] ?? '',
  //     returnPolicy: json['returnPolicy'] ?? '',
  //     images: List<String>.from(json['images'] ?? []),
  //     reviews: List<ReviewEntity>.from(
  //       (json['reviews'] ?? []).map((x) => ReviewModel.fromJson(x)),
  //     ),
  //     meta: MetaModel.fromJson(json['meta'] ?? {}),
  //   );
  // }

  ProductDetailsEntity toEntity() {
    return ProductDetailsEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      thumbnail: thumbnail,
      category: category,
      rating: rating,
      discountPercentage: discountPercentage,
      tags: tags,
      brand: brand,
      warrantyInformation: warrantyInformation,
      availabilityStatus: availabilityStatus,
      returnPolicy: returnPolicy,
      images: images,
      reviews: reviews,
      qrCodeUrl: qrCodeUrl,
    );
  }

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModelMapper.fromMap(json);
}

@MappableClass(generateMethods: GenerateMethods.decode)
class MetaModel with MetaModelMappable {
  MetaModel({required this.qrCode});

  final String qrCode;

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      MetaModelMapper.fromMap(json);
}

@MappableClass(generateMethods: GenerateMethods.decode)
class ReviewModel extends ReviewEntity with ReviewModelMappable {
  ReviewModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
    required super.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      ReviewModelMapper.fromMap(json);

  // factory ReviewModel.fromJson(Map<String, dynamic> json) {
  //   return ReviewModel(
  //     rating: json['rating'] ?? 0,
  //     comment: json['comment'] ?? '',
  //     date: json['date'] ?? '',
  //     reviewerName: json['reviewerName'] ?? '',
  //     reviewerEmail: json['reviewerEmail'] ?? '',
  //   );
  // }
}
