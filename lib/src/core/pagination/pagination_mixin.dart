import 'dart:ui';

abstract class PaginationStrategy<T> {
  void resetList(List<T> itemList);
  bool hasMore({
    required bool reset,
    required int total,
    required int currentLength,
  });
  List<T> getUpdatedItems({
    required bool reset,
    required List<T> newItems,
    required List<T> itemList,
    required VoidCallback updateNextParam,
  });
}

class OffsetPaginationStrategy<T> implements PaginationStrategy<T> {
  @override
  void resetList(List<T> itemList) {
    itemList.clear();
  }

  @override
  bool hasMore({
    required bool reset,
    required int total,
    required int currentLength,
  }) {
    return reset ? true : (currentLength < total);
  }

  @override
  List<T> getUpdatedItems({
    required bool reset,
    required List<T> newItems,
    required List<T> itemList,
    required VoidCallback updateNextParam,
  }) {
    if (reset) {
      resetList(itemList);
    }

    updateNextParam();

    itemList.addAll(newItems);
    return List.unmodifiable(itemList);
  }
}

class PagePaginationStrategy<T> implements PaginationStrategy<T> {
  @override
  void resetList(List<T> itemList) {
    itemList.clear();
  }

  @override
  bool hasMore({
    required bool reset,
    required int total,
    required int currentLength,
  }) {
    return reset ? true : (currentLength < total);
  }

  @override
  List<T> getUpdatedItems({
    required bool reset,
    required List<T> newItems,
    required List<T> itemList,
    required VoidCallback updateNextParam,
  }) {
    if (reset) {
      resetList(itemList);
    }

    updateNextParam();

    itemList.addAll(newItems);
    return List.unmodifiable(itemList);
  }
}

class CursorPaginationStrategy<T> implements PaginationStrategy<T> {
  @override
  void resetList(List<T> itemList) {
    itemList.clear();
  }

  @override
  bool hasMore({
    required bool reset,
    required int total,
    required int currentLength,
  }) {
    return reset ? true : (currentLength < total);
  }

  @override
  List<T> getUpdatedItems({
    required bool reset,
    required List<T> newItems,
    required List<T> itemList,
    required VoidCallback updateNextParam,
  }) {
    if (reset) {
      resetList(itemList);
    }

    updateNextParam();

    itemList.addAll(newItems);
    return List.unmodifiable(itemList);
  }
}
