import 'package:do_commerce/src/core/pagination/pagination_strategies.dart';
import 'package:flutter_test/flutter_test.dart';

PageResult<int> _page(List<int> items, PaginationMeta meta) =>
    PageResult(items: items, meta: meta);

void main() {
  group('PagePaginationStrategy', () {
    late PagePaginationStrategy<int> strategy;

    setUp(() => strategy = PagePaginationStrategy<int>());

    test('returns 1 as next param on reset', () {
      expect(strategy.getNextParam(true), 1);
    });

    test('moves to page + 1 after onPageLoaded', () {
      strategy.onPageLoaded(
        reset: false,
        page: _page([1], const PaginationMeta(page: 1)),
        itemList: [],
      );
      expect(strategy.getNextParam(false), 2);
    });

    test('counts on the client when the API omits the page', () {
      strategy.onPageLoaded(
        reset: false,
        page: _page([1], const PaginationMeta()),
        itemList: [],
      );
      expect(strategy.getNextParam(false), 2);
    });

    test('replaces items when reset is true', () {
      final result = strategy.onPageLoaded(
        reset: true,
        page: _page([4, 5], const PaginationMeta(page: 1)),
        itemList: [1, 2, 3],
      );
      expect(result, [4, 5]);
    });

    test('appends items when reset is false', () {
      final result = strategy.onPageLoaded(
        reset: false,
        page: _page([4, 5], const PaginationMeta(page: 2)),
        itemList: [1, 2, 3],
      );
      expect(result, [1, 2, 3, 4, 5]);
    });
  });

  group('OffsetPaginationStrategy', () {
    late OffsetPaginationStrategy<int> strategy;

    setUp(() => strategy = OffsetPaginationStrategy<int>());

    test('returns 0 as next param on reset', () {
      expect(strategy.getNextParam(true), 0);
    });

    test('moves to offset + limit after onPageLoaded', () {
      strategy.onPageLoaded(
        reset: false,
        page: _page([1], const PaginationMeta(offset: 0)),
        itemList: [],
      );
      expect(strategy.getNextParam(false), 10);
    });
  });

  group('CursorPaginationStrategy', () {
    late CursorPaginationStrategy<int> strategy;

    setUp(() => strategy = CursorPaginationStrategy<int>());

    test('returns null as next param on reset', () {
      expect(strategy.getNextParam(true), isNull);
    });

    test('stores the server cursor after onPageLoaded', () {
      strategy.onPageLoaded(
        reset: false,
        page: _page([1], const PaginationMeta(nextCursor: 'abc')),
        itemList: [],
      );
      expect(strategy.getNextParam(false), 'abc');
    });

    test('clears the cursor when the server returns none', () {
      strategy.onPageLoaded(
        reset: false,
        page: _page([1], const PaginationMeta()),
        itemList: [],
      );
      expect(strategy.getNextParam(false), isNull);
    });
  });
}
