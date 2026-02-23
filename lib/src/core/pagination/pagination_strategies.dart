abstract class PaginationStrategy<T> {
  int get limit;

  List<T> getUpdatedItems({
    required bool reset,
    required List<T> newItems,
    required List<T> itemList,
  });

  dynamic getNextParam(bool reset);

  void updateNextParam({dynamic nextParam});
}

abstract class BasePaginationStrategy<T> implements PaginationStrategy<T> {
  @override
  List<T> getUpdatedItems({
    required bool reset,
    required List<T> newItems,
    required List<T> itemList,
  }) {
    if (reset) {
      itemList.clear();
    }
    itemList.addAll(newItems);
    return List.unmodifiable(itemList);
  }
}

class PagePaginationStrategy<T> extends BasePaginationStrategy<T> {
  int _page = 1;

  @override
  int get limit => 10;

  @override
  int getNextParam(bool reset) {
    return reset ? 1 : _page;
  }

  @override
  void updateNextParam({dynamic nextParam}) {
    if (nextParam is! int) {
      throw ArgumentError.value(
        nextParam,
        'nextParam',
        'Expected an int for PagePaginationStrategy',
      );
    }
    _page = nextParam + 1;
  }
}

class OffsetPaginationStrategy<T> extends BasePaginationStrategy<T> {
  int _offset = 0;

  @override
  int get limit => 10;

  @override
  int getNextParam(bool reset) {
    return reset ? 0 : _offset;
  }

  @override
  void updateNextParam({dynamic nextParam}) {
    if (nextParam is! int) {
      throw ArgumentError.value(
        nextParam,
        'nextParam',
        'Expected an int for OffsetPaginationStrategy',
      );
    }
    _offset = nextParam + limit;
  }
}

class CursorPaginationStrategy<T> extends BasePaginationStrategy<T> {
  String? _cursor;

  @override
  int get limit => 10;

  @override
  String? getNextParam(bool reset) {
    return reset ? null : _cursor;
  }

  @override
  void updateNextParam({dynamic nextParam}) {
    if (nextParam != null && nextParam is! String) {
      throw ArgumentError.value(
        nextParam,
        'nextParam',
        'Expected a String or null for CursorPaginationStrategy',
      );
    }
    _cursor = nextParam;
  }
}
