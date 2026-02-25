import 'package:flutter_test/flutter_test.dart';
import 'package:do_commerce/src/data/models/product_model.dart';

void main() {
  group('ProductModel', () {
    final Map<String, dynamic> sampleJson = {
      'id': 1,
      'title': 'Test Product',
      'description': 'Test Description',
      'price': 99.99,
      'thumbnail': 'thumb.png',
      'category': 'test',
      'rating': 4.5,
      'discountPercentage': 10.0,
    };

    test('fromJson should create a valid ProductModel', () {
      final model = ProductModel.fromJson(sampleJson);

      expect(model.id, 1);
      expect(model.title, 'Test Product');
      expect(model.price, 99.99);
      expect(model.discountPercentage, 10.0);
    });

    test('getDiscountPrice should return correct value', () {
      final model = ProductModel.fromJson(sampleJson);
      // 99.99 - (99.99 * 0.1) = 99.99 - 9.999 = 89.991 -> 89.99
      expect(model.getDiscountPrice(), '89.99');
    });

    test('fromJson handle boundary: zero price', () {
      final json = Map<String, dynamic>.from(sampleJson)..['price'] = 0;
      final model = ProductModel.fromJson(json);
      expect(model.price, 0);
      expect(model.getDiscountPrice(), '0.00');
    });

    test('fromJson handle boundary: 100% discount', () {
      final json = Map<String, dynamic>.from(sampleJson)
        ..['discountPercentage'] = 100;
      final model = ProductModel.fromJson(json);
      expect(model.getDiscountPrice(), '0.00');
    });
  });

  group('ProductListModel', () {
    test('fromJson should create valid ProductListModel', () {
      final json = {
        'products': [
          {
            'id': 1,
            'title': 'P1',
            'description': 'D1',
            'price': 10,
            'thumbnail': 'T1',
            'category': 'C1',
            'rating': 4,
            'discountPercentage': 5,
          },
        ],
        'total': 100,
        'skip': 10,
        'page': 2,
        'cursor': 'next_cursor',
      };

      final model = ProductListModel.fromJson(json);

      expect(model.products.length, 1);
      expect(model.products.first.id, 1);
      expect(model.total, 100);
      expect(model.offset, 10);
      expect(model.page, 2);
      expect(model.cursor, 'next_cursor');
    });

    test('fromJson handle empty products list', () {
      final json = {'products': [], 'total': 0, 'skip': 0};

      final model = ProductListModel.fromJson(json);
      expect(model.products, isEmpty);
      expect(model.total, 0);
    });
  });
}
