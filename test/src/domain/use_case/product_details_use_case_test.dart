import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:do_commerce/src/domain/use_case/product_details_use_case.dart';
import 'package:do_commerce/src/domain/entity/product_details_entity.dart';

import '../../../mocks.mocks.dart';

void main() {
  late ProductDetailsUseCase useCase;
  late MockProductDetailsRepository mockRepository;

  setUp(() {
    mockRepository = MockProductDetailsRepository();
    useCase = ProductDetailsUseCase(productDetailsRepository: mockRepository);
  });

  group('ProductDetailsUseCase', () {
    final mockProduct = ProductDetailsEntity(
      id: 1,
      title: 'Test',
      description: 'Desc',
      price: 10,
      thumbnail: 'T',
      category: 'C',
      rating: 5,
      discountPercentage: 0,
      tags: [],
      brand: 'B',
      warrantyInformation: 'W',
      availabilityStatus: 'A',
      returnPolicy: 'R',
      images: [],
      reviews: [],
      qrCodeUrl: 'Q',
    );

    test('should call repository and return product details', () async {
      // Setup
      when(
        mockRepository.getProductDetails(1),
      ).thenAnswer((_) async => mockProduct);

      // Execute
      final result = await useCase.call(1);

      // Verify
      expect(result, mockProduct);
      verify(mockRepository.getProductDetails(1)).called(1);
    });

    test('should rethrow error on repository failure', () async {
      // Setup
      when(mockRepository.getProductDetails(1)).thenThrow(Exception('Fail'));

      // Execute & Verify
      expect(() => useCase.call(1), throwsA(isA<Exception>()));
    });
  });
}
