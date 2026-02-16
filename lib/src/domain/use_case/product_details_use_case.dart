import 'package:do_commerce/src/domain/entity/product_details_entity.dart';
import 'package:do_commerce/src/domain/repository/product_details_repository.dart';

class ProductDetailsUseCase {
  final ProductDetailsRepository productDetailsRepository;

  ProductDetailsUseCase({required this.productDetailsRepository});

  Future<ProductDetailsEntity> call(int id) async {
    try {
      return productDetailsRepository.getProductDetails(id);
    } catch (e) {
      rethrow;
    }
  }
}
