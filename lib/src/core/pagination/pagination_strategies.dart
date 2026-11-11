/// What the API reported about a page, independent of the pagination type.
/// Each strategy reads only the field it cares about.
final class PaginationMeta {
  const PaginationMeta({this.page, this.offset, this.nextCursor});

  /// Page-based: the page the API just returned.
  final int? page;

  /// Offset-based: the offset/skip the API just returned.
  final int? offset;

  /// Cursor-based: the cursor to use for the NEXT request.
  final String? nextCursor;
}

final class PageResult<T> {
  const PageResult({required this.items, required this.meta});

  final List<T> items;
  final PaginationMeta meta;
}

abstract class PaginationStrategy<T> {
  int get limit;

  /// Value to send in the next request (page number, offset or cursor).
  dynamic getNextParam(bool reset);

  /// The only write entry point. Privately updates the next page/offset/cursor
  /// from [page.meta], then merges [page.items] into [itemList].
  List<T> onPageLoaded({
    required bool reset,
    required PageResult<T> page,
    required List<T> itemList,
  });
}

abstract class _BasePaginationStrategy<T> implements PaginationStrategy<T> {
  @override
  List<T> onPageLoaded({
    required bool reset,
    required PageResult<T> page,
    required List<T> itemList,
  }) {
    _updateNextParam(page.meta);

    if (reset) {
      itemList.clear();
    }
    itemList.addAll(page.items);
    return List.unmodifiable(itemList);
  }

  /// Each strategy picks only the field it cares about from [meta].
  void _updateNextParam(PaginationMeta meta);
}

final class PagePaginationStrategy<T> extends _BasePaginationStrategy<T> {
  int _page = 1;

  @override
  int get limit => 10;

  @override
  int getNextParam(bool reset) => reset ? 1 : _page;

  @override
  void _updateNextParam(PaginationMeta meta) {
    // API returns the current page; fall back to client counting if omitted.
    _page = (meta.page ?? _page) + 1;
  }
}

final class OffsetPaginationStrategy<T> extends _BasePaginationStrategy<T> {
  int _offset = 0;

  @override
  int get limit => 10;

  @override
  int getNextParam(bool reset) => reset ? 0 : _offset;

  @override
  void _updateNextParam(PaginationMeta meta) {
    // API returns the current offset; the next one is offset + limit.
    _offset = (meta.offset ?? _offset) + limit;
  }
}

final class CursorPaginationStrategy<T> extends _BasePaginationStrategy<T> {
  String? _cursor;

  @override
  int get limit => 10;

  @override
  String? getNextParam(bool reset) => reset ? null : _cursor;

  @override
  void _updateNextParam(PaginationMeta meta) {
    // The cursor is decided by the server; the client can't compute it.
    _cursor = meta.nextCursor;
  }
}
