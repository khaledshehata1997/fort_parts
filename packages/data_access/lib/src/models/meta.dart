class Meta {
  Meta({
    required this.currentPage,
    required this.totalPages,
  });

  final int currentPage;
  final int totalPages;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json['current'],
        totalPages: json['total'],
      );
}
