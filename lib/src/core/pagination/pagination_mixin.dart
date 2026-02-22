// pagination_strategy.dart

import 'dart:ui';

abstract class PaginationStrategy<T> {
  List<T> getUpdatedItems({
    required bool reset,
    required List<T> newItems,
    required List<T> itemList,
    required VoidCallback updateNextParam,
  });
}

/// Base implementation shared by page, offset, and cursor strategies.
abstract class _BasePaginationStrategy<T> implements PaginationStrategy<T> {
  @override
  List<T> getUpdatedItems({
    required bool reset,
    required List<T> newItems,
    required List<T> itemList,
    required VoidCallback updateNextParam,
  }) {
    if (reset) itemList.clear();
    updateNextParam();
    itemList.addAll(newItems);
    return List.unmodifiable(itemList);
  }
}

class PagePaginationStrategy<T> extends _BasePaginationStrategy<T> {}

class OffsetPaginationStrategy<T> extends _BasePaginationStrategy<T> {}

class CursorPaginationStrategy<T> extends _BasePaginationStrategy<T> {}
