import 'package:flutter_test/flutter_test.dart';
import 'package:do_commerce/src/core/pagination/pagination_strategies.dart';

void main() {
  group('PagePaginationStrategy', () {
    late PagePaginationStrategy<int> strategy;

    setUp(() {
      strategy = PagePaginationStrategy<int>();
    });

    test('should return 1 as next param on reset', () {
      expect(strategy.getNextParam(true), 1);
    });

    test('should increment page after updateNextParam', () {
      strategy.updateNextParam(nextParam: 1);
      expect(strategy.getNextParam(false), 2);
    });

    test(
      'should reset items when getUpdatedItems is called with reset: true',
      () {
        final itemList = [1, 2, 3];
        final newItems = [4, 5];
        final result = strategy.getUpdatedItems(
          reset: true,
          newItems: newItems,
          itemList: itemList,
        );

        expect(result, [4, 5]);
      },
    );
  });

  group('OffsetPaginationStrategy', () {
    late OffsetPaginationStrategy<int> strategy;

    setUp(() {
      strategy = OffsetPaginationStrategy<int>();
    });

    test('should return 0 as next param on reset', () {
      expect(strategy.getNextParam(true), 0);
    });

    test('should increment offset by limit after updateNextParam', () {
      strategy.updateNextParam(nextParam: 0);
      expect(strategy.getNextParam(false), 10);
    });
  });
}
