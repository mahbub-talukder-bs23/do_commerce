import 'package:flutter_test/flutter_test.dart';
import 'package:do_commerce/src/data/models/product_details_model.dart';
import 'package:do_commerce/src/domain/entity/product_details_entity.dart';

void main() {
  group('ProductDetailsModel', () {
    final json = {
      'id': 1,
      'title': 'iPhone 9',
      'description': 'An apple mobile which is nothing like apple',
      'price': 549.0,
      'thumbnail': '...',
      'category': 'smartphones',
      'rating': 4.69,
      'discountPercentage': 12.96,
      'tags': ['smartphone', 'apple'],
      'brand': 'Apple',
      'warrantyInformation': '1 year',
      'availabilityStatus': 'In Stock',
      'returnPolicy': '30 days',
      'images': ['...'],
      'reviews': [
        {
          'rating': 5,
          'comment': 'Great product!',
          'date': '2024-01-01',
          'reviewerName': 'John Doe',
          'reviewerEmail': 'john@example.com',
        },
      ],
      'meta': {'qrCode': '...'},
    };

    test('should return a valid model from JSON', () {
      final model = ProductDetailsModel.fromJson(json);

      expect(model.id, 1);
      expect(model.title, 'iPhone 9');
      expect(model.price, 549.0);
      expect(model.reviews.length, 1);
      expect(model.reviews.first.comment, 'Great product!');
      expect(model.qrCodeUrl, '...');
    });

    test('should convert to entity correctly', () {
      final model = ProductDetailsModel.fromJson(json);
      final entity = model.toEntity();

      expect(entity, isA<ProductDetailsEntity>());
      expect(entity.id, model.id);
      expect(entity.title, model.title);
    });
  });
}
