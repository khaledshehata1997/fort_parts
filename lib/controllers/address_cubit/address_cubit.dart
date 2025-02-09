import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/address_cubit/address_states.dart';
import 'package:local_storage/local_storage.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit() : super(AddressInitialState());

  Future<void> fetchAddresses() async {
    try {
      final HiveUser? user = await HiveHelper.get(hiveBox: HiveBoxes.user);
      if (user != null) {
        emit(FetchAddressesState(stateStatus: StateStatus.loading));
        final List<Address> addresses = await sl<IAddressRepository>().fetchAddresses();

        emit(FetchAddressesState(
          stateStatus: StateStatus.success,
          addresses: addresses,
        ));
      }
    } catch (e) {
      emit(FetchAddressesState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> addAddress({
    required String latitude,
    required String longitude,
    required String name,
    required String address,
    required String build,
    required String floor,
  }) async {
    try {
      emit(AddAddressesState(stateStatus: StateStatus.loading));
      await sl<IAddressRepository>().addAddress(
        latitude: latitude,
        longitude: longitude,
        name: name,
        address: address,
        build: build,
        floor: floor,
      );

      emit(AddAddressesState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(AddAddressesState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}
