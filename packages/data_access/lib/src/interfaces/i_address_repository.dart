import 'package:data_access/data_access.dart';

abstract class IAddressRepository {
  Future<List<Address>> fetchAddresses();

  Future<void> addAddress({
    required String latitude,
    required String longitude,
    required String name,
    required String address,
    required String build,
    required String floor,
  });

  Future<void> deleteAddress({
    required int addressID,
  });
}
