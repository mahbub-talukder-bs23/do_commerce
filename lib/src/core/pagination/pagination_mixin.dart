mixin PaginationMixin<T> {
  final List<T> _itemList = [];
  List<T> get itemList => _itemList.toList();

  void clearItemList() => _itemList.clear();
  void addItems(List<T> items) => _itemList.addAll(items);
}

mixin OffsetPaginationStrategyMixin<T> on PaginationMixin<T> {
  int calculateOffset(bool reset) {
    return reset ? 0 : itemList.length;
  }
}

mixin PagePaginationStrategyMixin<T> on PaginationMixin<T> {
  int calculatePage(int limit, bool reset) {
    return reset ? 1 : (itemList.length ~/ limit) + 1;
  }
}

mixin CursorPaginationStrategyMixin<T> on PaginationMixin<T> {
  String? _cursor;

  String? get cursor => _cursor;

  void clearCursor() => _cursor = null;

  void setCursor(String? cursor) {
    _cursor = cursor;
  }

  String? calculateCursor(bool reset) => reset ? null : _cursor;
}

// mixin ProductPaginationMixin {
//   final List<ProductEntity> _productList = [];

//   List<ProductEntity> get productList => _productList.toList();

//   void clearProductList() {
//     _productList.clear();
//   }

//   void addProducts(List<ProductEntity> products) {
//     _productList.addAll(products);
//   }
// }

// mixin OffsetPaginationMixin {
//   int calculateOffset(int length, bool reset) => reset ? 0 : length;
// }

// mixin PagePaginationMixin {
//   int calculatePage(int length, int limit, bool reset) =>
//       reset ? 1 : (length ~/ limit) + 1;
// }

// mixin CursorPaginationMixin {
//   String? _cursor;

//   String? get cursor => _cursor;

//   void clearCursor() => _cursor = null;

//   void setCursor(String? cursor) {
//     _cursor = cursor;
//   }

//   String? calculateCursor(bool reset) => reset ? null : _cursor;
// }

// Your base mixin remains the same
