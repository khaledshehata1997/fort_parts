import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class AddressRepository implements IAddressRepository {
  @override
  Future<List<Address>> fetchAddresses() async {
    try {
      final String url = EndPoints.fetchAddresses();

      final Response response = await sl<IApiRepository>().get(url: url);

      final List<Address> addresses = List<Address>.from(response.data['data'].map((x) => Address.fromJson(x)));

      return addresses;
    } catch (e) {
      rethrow;
    }
  }
}
