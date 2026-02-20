class PaginationRequestEntity {
  bool reset;
  String? cursor;
  int? page;
  int? offset;
  int limit;
  String? search;
  String? category;

  PaginationRequestEntity({
    this.reset = false,
    this.cursor,
    this.page,
    this.offset,
    this.limit = 10,
    this.search,
    this.category,
  });
}
