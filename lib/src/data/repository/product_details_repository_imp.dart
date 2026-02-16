import 'dart:convert';

import 'package:do_commerce/src/core/logger/logger.dart';
import 'package:do_commerce/src/data/models/product_details_model.dart';
import 'package:do_commerce/src/data/services/network/api_end_points.dart';
import 'package:do_commerce/src/data/services/network/rest_client/rest_client.dart';
import 'package:do_commerce/src/domain/entity/product_details_entity.dart';
import 'package:do_commerce/src/domain/repository/product_details_repository.dart';

class ProductDetailsRepositoryImp implements ProductDetailsRepository {
  ProductDetailsRepositoryImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<ProductDetailsEntity> getProductDetails(int id) async {
    try {
      final response = await restClient.get('${ApiEndPoints.products}/$id');

      return ProductDetailsModel.fromJson(response.data).toEntity();
    } catch (e, stackTrace) {
      logger.e(e, stackTrace: stackTrace);
      throw Exception(e.toString());
    }
  }
}
