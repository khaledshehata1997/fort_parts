import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_states.dart';
import 'package:fort_parts/view/auth/sign_in_view.dart';
import 'package:local_storage/local_storage.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  Cart cart = Cart(total: 0, products: []);

  Future<void> fetchCart() async {
    try {
      final HiveUser? user = await HiveHelper.get(hiveBox: HiveBoxes.user);
      if (user != null) {
        emit(FetchCartState(stateStatus: StateStatus.loading));
        cart = await sl<ICartRepository>().fetchCart();

        emit(FetchCartState(stateStatus: StateStatus.success));
      }
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
      final HiveUser? user = await HiveHelper.get(hiveBox: HiveBoxes.user);
      if (user != null) {
        emit(UpdateItemInCartState(stateStatus: StateStatus.loading));
        cart = await sl<ICartRepository>().updateItemInCart(
          productID: productID,
          quantity: quantity,
        );

        emit(UpdateItemInCartState(stateStatus: StateStatus.success));
      } else {
        AppNavigator.navigateTo(type: NavigationType.navigateAndFinish, widget: SignInView());
      }
    } catch (e) {
      emit(UpdateItemInCartState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> deleteItemFromCart({
    required int productID,
  }) async {
    try {
      final HiveUser? user = await HiveHelper.get(hiveBox: HiveBoxes.user);
      if (user != null) {
        emit(DeleteItemFromCartState(stateStatus: StateStatus.loading));
        cart = await sl<ICartRepository>().deleteItemFromCart(productID: productID);

        emit(DeleteItemFromCartState(stateStatus: StateStatus.success));
      } else {
        AppNavigator.navigateTo(type: NavigationType.navigateAndFinish, widget: SignInView());
      }
    } catch (e) {
      emit(DeleteItemFromCartState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}
