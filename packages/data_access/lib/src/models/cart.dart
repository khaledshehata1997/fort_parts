import 'package:data_access/data_access.dart';

class Cart {
  Cart({
    required this.total,
    required this.products,
  });

  final double total;
  final List<CartProduct> products;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      total: double.parse(json['total'].toString()),
      products: List<CartProduct>.from(json['products'].map((x) => CartProduct.fromJson(x))),
    );
  }
}

class CartProduct {
  CartProduct({
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      product: Product.fromJson(json['product']),
      quantity: json['quy'],
    );
  }
}
