import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:do_commerce/src/domain/use_case/product_list_use_case.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/domain/entity/pagination_request_entity.dart';

import '../../../mocks.mocks.dart';

void main() {
  late ProductListUseCase useCase;
  late MockProductListRepository mockRepository;

  setUp(() {
    mockRepository = MockProductListRepository();
    useCase = ProductListUseCase(productListRepository: mockRepository);
  });

  group('ProductListUseCase', () {
    final mockProducts = [
      ProductEntity(
        id: 1,
        title: 'P1',
        description: 'D1',
        price: 1,
        thumbnail: 'T1',
        category: 'C1',
        rating: 1,
        discountPercentage: 0,
      ),
    ];

    test('should call repository with correct request entity', () async {
      // Setup
      when(
        mockRepository.getProductList(requestEntity: anyNamed('requestEntity')),
      ).thenAnswer((_) async => mockProducts);

      // Execute
      final result = await useCase.call(
        reset: true,
        search: 'test',
        category: 'cat',
      );

      // Verify
      expect(result, mockProducts);
      verify(
        mockRepository.getProductList(
          requestEntity: argThat(
            isA<PaginationRequestEntity>()
                .having((e) => e.reset, 'reset', true)
                .having((e) => e.search, 'search', 'test')
                .having((e) => e.category, 'category', 'cat'),
            named: 'requestEntity',
          ),
        ),
      ).called(1);
    });
  });
}
