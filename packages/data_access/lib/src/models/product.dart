class Product {
  Product({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.image,
  });

  final int id;
  final int price;
  final String name;
  final String description;
  final String image;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['unit_price'],
      name: json['name'],
      description: json['description'],
      image: json['images'],
    );
  }
}
