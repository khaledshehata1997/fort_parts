import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class CartRepository implements ICartRepository {
  @override
  Future<Cart> addToCart({
    required int productID,
    required int quantity,
  }) async {
    try {
      final String url = EndPoints.addToCart();
      final Map<String, dynamic> data = {
        'product_id': productID,
        'quy': quantity,
      };

      final Response response = await sl<IApiRepository>().post(url: url, rawData: data);

      final Cart cart = Cart.fromJson(response.data['data']);

      return cart;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Cart> fetchCart() async {
    try {
      final String url = EndPoints.myCart();

      final Response response = await sl<IApiRepository>().get(url: url);
      final Cart cart = Cart.fromJson(response.data['data']);
      return cart;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Cart> updateItemInCart({
    required int productID,
    required int quantity,
  }) async {
    try {
      final String url = EndPoints.updateCart();
      final Map<String, dynamic> data = {
        'product_id': productID,
        'quy': quantity,
      };

      final Response response = await sl<IApiRepository>().put(url: url, rawData: data);
      final Cart cart = Cart.fromJson(response.data['data']);
      return cart;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Cart> deleteItemFromCart({
    required int productID,
  }) async {
    try {
      final String url = EndPoints.deleteItemFromCart();
      final Map<String, dynamic> data = {
        'product_id': productID,
      };

      final Response response = await sl<IApiRepository>().post(url: url, rawData: data);
      final Cart cart = Cart.fromJson(response.data['data']);

      return cart;
    } catch (e) {
      rethrow;
    }
  }
}
