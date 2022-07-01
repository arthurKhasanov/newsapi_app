class PaginationListModel<T> {
  PaginationListModel({
    required final this.data,
  });

  factory PaginationListModel.fromJson(
    final Map<String, dynamic> json,
    final T Function(Map<String, dynamic>) fromJson,
  ) {
    if (json['items'] == null) {
      return PaginationListModel<T>(
        data: <T>[],
      );
    }


    return PaginationListModel<T>(
      data: (json['items'] as List)
          .map<T>((final e) => fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<T> data;
}