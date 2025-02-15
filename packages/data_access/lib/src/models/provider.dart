class Provider {
  Provider({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      name: json['name'] ?? "",
    );
  }
}
