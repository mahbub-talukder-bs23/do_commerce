import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:do_commerce/src/core/pagination/pagination_strategies.dart';
import 'package:do_commerce/src/data/repository/product_list_repository_impl.dart';
import 'package:do_commerce/src/domain/entity/pagination_request_entity.dart';
import 'package:do_commerce/src/domain/entity/product_entity.dart';
import 'package:do_commerce/src/data/services/local/paginated_data_source/paginated_data_source.dart';

import '../../../mocks.mocks.dart';

void main() {
  late ProductListRepositoryImpl repository;
  late MockRestClient mockRestClient;
  late MockPaginationStrategy<ProductEntity> mockPaginationStrategy;

  setUp(() {
    mockRestClient = MockRestClient();
    mockPaginationStrategy = MockPaginationStrategy();
    repository = ProductListRepositoryImpl(
      restClient: mockRestClient,
      paginationStrategy: mockPaginationStrategy,
    );
  });

  group('ProductListRepositoryImpl', () {
    final requestEntity = PaginationRequestEntity(reset: false);
    final responseData = {
      'products': [
        {
          'id': 1,
          'title': 'Test',
          'description': 'Desc',
          'price': 10,
          'thumbnail': 'T',
          'category': 'C',
          'rating': 5,
          'discountPercentage': 0,
        },
      ],
      'total': 1,
      'skip': 0,
      'page': 1,
    };

    test('getProductList should return updated items on success', () async {
      // Setup
      when(mockPaginationStrategy.limit).thenReturn(10);
      when(mockPaginationStrategy.getNextParam(false)).thenReturn(1);

      final response = Response(
        data: responseData,
        requestOptions: RequestOptions(path: ''),
      );

      when(
        mockRestClient.getPaginatedData(
          type: PaginationType.page,
          limit: 10,
          page: 1,
          search: anyNamed('search'),
          category: anyNamed('category'),
        ),
      ).thenAnswer((_) async => response);

      when(
        mockPaginationStrategy.onPageLoaded(
          reset: anyNamed('reset'),
          page: anyNamed('page'),
          itemList: anyNamed('itemList'),
        ),
      ).thenReturn([]);

      // Execute
      await repository.getProductList(requestEntity: requestEntity);

      // Verify
      verify(
        mockRestClient.getPaginatedData(
          type: PaginationType.page,
          limit: 10,
          page: 1,
          search: null,
          category: null,
        ),
      ).called(1);

      final captured = verify(
        mockPaginationStrategy.onPageLoaded(
          reset: false,
          page: captureAnyNamed('page'),
          itemList: anyNamed('itemList'),
        ),
      ).captured.single as PageResult<ProductEntity>;
      expect(captured.meta.page, 1);
      expect(captured.meta.offset, 0);
      expect(captured.items.single.id, 1);
    });

    test(
      'getProductList should rethrow error on rest client failure',
      () async {
        // Setup
        when(mockPaginationStrategy.limit).thenReturn(10);
        when(mockPaginationStrategy.getNextParam(false)).thenReturn(1);

        when(
          mockRestClient.getPaginatedData(
            type: anyNamed('type'),
            limit: anyNamed('limit'),
            page: anyNamed('page'),
            search: anyNamed('search'),
            category: anyNamed('category'),
          ),
        ).thenThrow(Exception('Network Error'));

        // Execute & Verify
        expect(
          () => repository.getProductList(requestEntity: requestEntity),
          throwsA(isA<Exception>()),
        );
      },
    );

    test(
      'getProductList should pass search and category params correctly',
      () async {
        // Setup
        final searchRequest = PaginationRequestEntity(
          reset: true,
          search: 'phone',
          category: 'electronics',
        );

        when(mockPaginationStrategy.limit).thenReturn(20);
        when(mockPaginationStrategy.getNextParam(true)).thenReturn(0);

        final response = Response(
          data: responseData,
          requestOptions: RequestOptions(path: ''),
        );

        when(
          mockRestClient.getPaginatedData(
            type: PaginationType.page,
            limit: 20,
            page: 0,
            search: 'phone',
            category: 'electronics',
          ),
        ).thenAnswer((_) async => response);

        when(
          mockPaginationStrategy.onPageLoaded(
            reset: anyNamed('reset'),
            page: anyNamed('page'),
            itemList: anyNamed('itemList'),
          ),
        ).thenReturn([]);

        // Execute
        await repository.getProductList(requestEntity: searchRequest);

        // Verify
        verify(
          mockRestClient.getPaginatedData(
            type: PaginationType.page,
            limit: 20,
            page: 0,
            search: 'phone',
            category: 'electronics',
          ),
        ).called(1);
      },
    );
  });
}
