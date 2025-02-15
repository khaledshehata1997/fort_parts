class SparePart {
  SparePart({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
  });

  final String name;
  final int quantity;
  final int price;
  final int total;

  factory SparePart.fromJson(Map<String, dynamic> json) {
    return SparePart(
      name: json['name'],
      quantity: json['quy'],
      price: json['unit_price'],
      total: json['total'],
    );
  }
}
