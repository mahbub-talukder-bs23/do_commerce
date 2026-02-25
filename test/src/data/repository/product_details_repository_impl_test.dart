import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:do_commerce/src/data/repository/product_details_repository_imp.dart';
import 'package:do_commerce/src/domain/entity/product_details_entity.dart';
import 'package:do_commerce/src/data/services/network/api_end_points.dart';

import '../../../mocks.mocks.dart';

void main() {
  late ProductDetailsRepositoryImp repository;
  late MockRestClient mockRestClient;

  setUp(() {
    mockRestClient = MockRestClient();
    repository = ProductDetailsRepositoryImp(restClient: mockRestClient);
  });

  group('ProductDetailsRepositoryImp', () {
    final productId = 1;
    final responseData = {
      'id': 1,
      'title': 'Test Product',
      'description': 'Description',
      'price': 100.0,
      'thumbnail': 'thumb',
      'category': 'cat',
      'rating': 4.5,
      'discountPercentage': 10.0,
      'tags': ['tag1'],
      'brand': 'brand',
      'warrantyInformation': '1 year',
      'availabilityStatus': 'In Stock',
      'returnPolicy': '30 days',
      'images': ['img1'],
      'reviews': [],
      'meta': {'qrCode': 'qr'},
    };

    test('getProductDetails should return entity on success', () async {
      // Setup
      final response = Response(
        data: responseData,
        requestOptions: RequestOptions(path: ''),
      );

      when(
        mockRestClient.get('${ApiEndPoints.products}/$productId'),
      ).thenAnswer((_) async => response);

      // Execute
      final result = await repository.getProductDetails(productId);

      // Verify
      expect(result, isA<ProductDetailsEntity>());
      expect(result.id, productId);
      expect(result.title, 'Test Product');
      verify(
        mockRestClient.get('${ApiEndPoints.products}/$productId'),
      ).called(1);
    });

    test('getProductDetails should throw exception on failure', () async {
      // Setup
      when(mockRestClient.get(any)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Network Error',
        ),
      );

      // Execute & Verify
      expect(
        () => repository.getProductDetails(productId),
        throwsA(isA<Exception>()),
      );
    });
  });
}
