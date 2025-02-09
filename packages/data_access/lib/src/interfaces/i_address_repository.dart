import 'package:data_access/data_access.dart';

abstract class IAddressRepository {
  Future<List<Address>> fetchAddresses();
}
