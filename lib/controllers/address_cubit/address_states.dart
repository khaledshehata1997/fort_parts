import 'package:components/components.dart';
import 'package:data_access/data_access.dart';

class AddressStates {}

class AddressInitialState extends AddressStates {}

class AddressRefreshState extends AddressStates {}

class FetchAddressesState extends AddressStates {
  FetchAddressesState({
    required this.stateStatus,
    this.addresses = const [],
  });
  final StateStatus stateStatus;
  final List<Address> addresses;
}

class AddAddressesState extends AddressStates {
  AddAddressesState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}
