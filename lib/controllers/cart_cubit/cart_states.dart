import 'package:components/components.dart';

class CartStates {}

class CartInitialState extends CartStates {}

class CartRefreshState extends CartStates {}

class FetchCartState extends CartStates {
  FetchCartState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}

class AddItemToCartState extends CartStates {
  AddItemToCartState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}

class UpdateItemInCartState extends CartStates {
  UpdateItemInCartState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}

class DeleteItemFromCartState extends CartStates {
  DeleteItemFromCartState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}
