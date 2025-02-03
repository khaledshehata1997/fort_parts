import 'package:data_access/data_access.dart';

abstract class ICartRepository {
  Future<Cart> addToCart({
    required int productID,
    required int quantity,
  });

  Future<Cart> fetchCart();

  Future<Cart> updateItemInCart({
    required int productID,
    required int quantity,
  });

  Future<Cart> deleteItemFromCart({
    required int productID,
  });
}
