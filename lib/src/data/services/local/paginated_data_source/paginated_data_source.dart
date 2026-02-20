part 'static_data.dart';

enum PaginationType { page, offset, cursor }

class PaginatedDataSource {
  /// Only for cursor based pagination
  int cursorValue = 0;

  static List<Map<String, dynamic>> _filterItems(
    List<Map<String, dynamic>> allItems,
    String? search,
    String? category,
  ) {
    return allItems.where((item) {
      final matchesSearch =
          search == null ||
          search.isEmpty ||
          item['title'].toString().toLowerCase().contains(
            search.toLowerCase(),
          ) ||
          item['description'].toString().toLowerCase().contains(
            search.toLowerCase(),
          );
      final matchesCategory =
          category == null || category.isEmpty || item['category'] == category;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  static Future<Map<String, dynamic>> getDataOnPageLimit({
    required int limit,
    required int page,
    String? search,
    String? category,
  }) async {
    final rawItems = StaticData.data['products'] as List<Map<String, dynamic>>;
    final allItems = _filterItems(rawItems, search, category);
    await Future.delayed(const Duration(seconds: 1));

    List<Map<String, dynamic>> response;

    if (page * limit > allItems.length) {
      int start = (page - 1) * limit;
      if (start >= allItems.length) {
        response = [];
      } else {
        response = allItems.sublist(start);
      }
    } else {
      response = allItems.sublist((page - 1) * limit, page * limit);
    }

    return {
      'products': response,
      'total': allItems.length,
      'page': page,
      'limit': limit,
    };
  }

  static Future<Map<String, dynamic>> getDataOnOffsetLimit({
    required int limit,
    required int offset,
    String? search,
    String? category,
  }) async {
    final rawItems = StaticData.data['products'] as List<Map<String, dynamic>>;
    final allItems = _filterItems(rawItems, search, category);
    await Future.delayed(const Duration(seconds: 1));

    List<Map<String, dynamic>> response;
    if (offset >= allItems.length) {
      response = [];
    } else if (offset + limit > allItems.length) {
      response = allItems.sublist(offset);
    } else {
      response = allItems.sublist(offset, offset + limit);
    }

    return {
      'products': response,
      'total': allItems.length,
      'skip': offset,
      'limit': limit,
    };
  }

  static Future<Map<String, dynamic>> getDataOnCursorLimit({
    required int limit,
    required String? cursor,
    String? search,
    String? category,
  }) async {
    final rawItems = StaticData.data['products'] as List<Map<String, dynamic>>;
    final allItems = _filterItems(rawItems, search, category);
    await Future.delayed(const Duration(seconds: 1));

    int startIndex = StaticData.cursorMapper[cursor] ?? 0;
    List<Map<String, dynamic>> response;

    if (startIndex >= allItems.length) {
      response = [];
    } else if (startIndex + limit > allItems.length) {
      response = allItems.sublist(startIndex);
    } else {
      response = allItems.sublist(startIndex, startIndex + limit);
    }

    int nextIndex = startIndex + response.length;

    return {
      'products': response,
      'total': allItems.length,
      'cursor': nextIndex < allItems.length ? 'cursorValue$nextIndex' : null,
      'limit': limit,
    };
  }
}
/**
 *  "total": 194,
    "skip": 0,
    "limit": 50,
    "cursor": {
      "next": "cursorValue50",
      "prev": null,
    },
 */