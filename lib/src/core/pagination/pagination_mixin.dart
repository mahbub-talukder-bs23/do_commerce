abstract class PaginationStrategy<T, P> {
  P getNextParameter(int? limit, bool reset);
  List<T> updateAndGetItems(List<T> items, String? nextCursor);
}

class OffsetPaginationStrategy<T> implements PaginationStrategy<T, int> {
  final List<T> _itemList = [];

  @override
  int getNextParameter(int? limit, bool reset) {
    if (reset) _itemList.clear();
    return _itemList.length;
  }

  @override
  List<T> updateAndGetItems(List<T> items, String? nextCursor) {
    _itemList.addAll(items);
    return List.unmodifiable(_itemList);
  }
}

class PagePaginationStrategy<T> implements PaginationStrategy<T, int> {
  final List<T> _itemList = [];

  @override
  int getNextParameter(int? limit, bool reset) {
    if (reset) _itemList.clear();

    return (_itemList.length ~/ limit!) + 1;
  }

  @override
  List<T> updateAndGetItems(List<T> items, String? nextCursor) {
    _itemList.addAll(items);
    return List.unmodifiable(_itemList);
  }
}

class CursorPaginationStrategy<T> implements PaginationStrategy<T, String?> {
  final List<T> _itemList = [];
  String? _currentCursor;

  @override
  String? getNextParameter(int? limit, bool reset) {
    if (reset) {
      _itemList.clear();
      _currentCursor = null;
    }
    return _currentCursor;
  }

  @override
  List<T> updateAndGetItems(List<T> items, String? nextCursor) {
    _currentCursor = nextCursor;
    _itemList.addAll(items);
    return List.unmodifiable(_itemList);
  }
}
