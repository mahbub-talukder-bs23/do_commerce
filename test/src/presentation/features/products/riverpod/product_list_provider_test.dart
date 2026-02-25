import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:do_commerce/src/presentation/features/products/riverpod/product_list_provider.dart';
import 'package:do_commerce/src/core/di/di.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';

import '../../../../../mocks.mocks.dart';

void main() {
  late MockProductListUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockProductListUseCase();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [productListUseCaseProvider.overrideWithValue(mockUseCase)],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('ProductList Provider', () {
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

    test('should fetch products on build', () async {
      // Setup
      when(
        mockUseCase.call(
          reset: true,
          search: anyNamed('search'),
          category: anyNamed('category'),
        ),
      ).thenAnswer((_) async => mockProducts);

      final container = createContainer();

      // Execute
      final result = await container.read(productListProvider.future);

      // Verify
      expect(result, mockProducts);
      verify(
        mockUseCase.call(reset: true, search: null, category: null),
      ).called(1);
    });

    test(
      'should update state to loading then data on loadMoreProduct',
      () async {
        // Setup
        when(
          mockUseCase.call(
            reset: anyNamed('reset'),
            search: anyNamed('search'),
            category: anyNamed('category'),
          ),
        ).thenAnswer((_) async => mockProducts);

        final container = createContainer();
        final listener = Listener<AsyncValue<List<ProductEntity>>>();

        container.listen(
          productListProvider,
          listener.call,
          fireImmediately: true,
        );

        // Initial load
        await container.read(productListProvider.future);

        // Execute loadMore
        await container.read(productListProvider.notifier).loadMoreProduct();

        // Verify
        verify(
          mockUseCase.call(reset: false, search: null, category: null),
        ).called(1);
      },
    );
  });
}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
