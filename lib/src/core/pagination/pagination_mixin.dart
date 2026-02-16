mixin OffsetPaginationStrategyMixin<T> {
  int calculateOffset({required bool reset, required List<T> itemList}) {
    if (reset) itemList.clear();

    return itemList.length;
  }

  List<T> getPaginatedItems({
    required List<T> newItems,
    required List<T> itemList,
  }) {
    return (itemList..addAll(newItems)).toList();
  }
}

mixin PagePaginationStrategyMixin<T> {
  int calculatePage({
    required int limit,
    required bool reset,
    required List<T> itemList,
  }) {
    if (reset) itemList.clear();

    return (itemList.length ~/ limit) + 1;
  }

  List<T> getPaginatedItems({
    required List<T> newItems,
    required List<T> itemList,
  }) {
    return (itemList..addAll(newItems)).toList();
  }
}

mixin CursorPaginationStrategyMixin<T> {
  String? _cursor;

  String? calculateCursor({required bool reset, required List<T> itemList}) {
    if (reset) itemList.clear();

    return reset ? null : _cursor;
  }

  List<T> getPaginatedItems({
    required List<T> newItems,
    required String? newCursor,
    required List<T> itemList,
  }) {
    _cursor = newCursor;

    return (itemList..addAll(newItems)).toList();
  }
}
