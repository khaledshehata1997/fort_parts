import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/address_cubit/address_states.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit() : super(AddressInitialState());

  Future<void> fetchAddresses() async {
    try {
      emit(FetchAddressesState(stateStatus: StateStatus.loading));
      final List<Address> addresses = await sl<IAddressRepository>().fetchAddresses();

      emit(FetchAddressesState(
        stateStatus: StateStatus.success,
        addresses: addresses,
      ));
    } catch (e) {
      emit(FetchAddressesState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}
