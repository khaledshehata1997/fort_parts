import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  Cart cart = Cart(total: 0, products: []);
  Future<void> addToCart({
    required int productID,
    required int quantity,
  }) async {
    try {
      emit(AddItemToCartState(stateStatus: StateStatus.loading));
      cart = await sl<ICartRepository>().addToCart(
        productID: productID,
        quantity: quantity,
      );

      emit(AddItemToCartState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(AddItemToCartState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> fetchCart() async {
    try {
      emit(FetchCartState(stateStatus: StateStatus.loading));
      cart = await sl<ICartRepository>().fetchCart();

      emit(FetchCartState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(FetchCartState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> updateItemInCartState({
    required int productID,
    required int quantity,
  }) async {
    try {
      emit(UpdateItemInCartState(stateStatus: StateStatus.loading));

      cart = await sl<ICartRepository>().updateItemInCart(
        productID: productID,
        quantity: quantity,
      );

      emit(UpdateItemInCartState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(UpdateItemInCartState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> deleteItemFromCart({
    required int productID,
  }) async {
    try {
      emit(DeleteItemFromCartState(stateStatus: StateStatus.loading));
      cart = await sl<ICartRepository>().deleteItemFromCart(productID: productID);

      emit(DeleteItemFromCartState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(DeleteItemFromCartState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}
