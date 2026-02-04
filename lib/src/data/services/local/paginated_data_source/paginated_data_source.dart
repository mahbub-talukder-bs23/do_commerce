part 'static_data.dart';

enum PaginationType { page, skip, cursor }

class PaginatedDataSource {
  /// Only for cursor based pagination
  int cursorValue = 0;

  static Future<Map<String, dynamic>> getDataOnPageLimit({
    required int limit,
    required int page,
  }) async {
    final allItems = StaticData.data['products'] as List<Map<String, dynamic>>;
    await Future.delayed(const Duration(seconds: 1));

    List<Map<String, dynamic>> response;

    if (page * limit > allItems.length) {
      response = [];
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

  static Future<Map<String, dynamic>> getDataOnSkipLimit({
    required int limit,
    required int skip,
  }) async {
    final allItems = StaticData.data['products'] as List<Map<String, dynamic>>;
    await Future.delayed(const Duration(seconds: 1));

    List<Map<String, dynamic>> response;
    if (skip + limit > allItems.length) {
      response = [];
    } else {
      response = allItems.sublist(skip, skip + limit);
    }

    return {
      'products': response,
      'total': allItems.length,
      'skip': skip,
      'limit': limit,
    };
  }

  static Future<Map<String, dynamic>> getDataOnCursorLimit({
    required int limit,
    required String? cursor,
  }) async {
    final allItems = StaticData.data['products'] as List<Map<String, dynamic>>;
    await Future.delayed(const Duration(seconds: 1));

    List<Map<String, dynamic>> response;
    if (StaticData.cursorMapper[cursor] == null ||
        (StaticData.cursorMapper[cursor] ?? 0) + limit > allItems.length) {
      response = [];
    } else {
      response = allItems.sublist(
        StaticData.cursorMapper[cursor] ?? 0,
        (StaticData.cursorMapper[cursor] ?? 0) + limit,
      );
    }

    return {
      'products': response,
      'total': allItems.length,
      'cursor': 'cursorValue${(StaticData.cursorMapper[cursor] ?? 50) + limit}',
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