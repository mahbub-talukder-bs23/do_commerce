mixin OffsetPaginationStrategyMixin<T> {
  final List<T> _itemList = [];

  int calculateOffset(bool reset) {
    if (reset) _itemList.clear();

    return _itemList.length;
  }

  List<T> getPaginatedItems({required List<T> newItems}) {
    return (_itemList..addAll(newItems)).toList();
  }
}

mixin PagePaginationStrategyMixin<T> {
  final List<T> _itemList = [];

  int calculatePage(int limit, bool reset) {
    if (reset) _itemList.clear();

    return (_itemList.length ~/ limit) + 1;
  }

  List<T> getPaginatedItems({required List<T> newItems}) {
    return (_itemList..addAll(newItems)).toList();
  }
}

mixin CursorPaginationStrategyMixin<T> {
  final List<T> _itemList = [];

  String? _cursor;

  String? calculateCursor(bool reset) {
    if (reset) _itemList.clear();

    return reset ? null : _cursor;
  }

  List<T> getPaginatedItems({
    required List<T> newItems,
    required String? newCursor,
  }) {
    _cursor = newCursor;

    return (_itemList..addAll(newItems)).toList();
  }
}
