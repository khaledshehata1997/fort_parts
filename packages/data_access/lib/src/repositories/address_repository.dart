import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class AddressRepository implements IAddressRepository {
  @override
  Future<List<Address>> fetchAddresses() async {
    try {
      final String url = EndPoints.address();

      final Response response = await sl<IApiRepository>().get(url: url);

      final List<Address> addresses = List<Address>.from(response.data['data'].map((x) => Address.fromJson(x)));

      return addresses;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addAddress({
    required String latitude,
    required String longitude,
    required String name,
    required String address,
    required String build,
    required String floor,
  }) async {
    try {
      final String url = EndPoints.address();
      final Map<String, dynamic> data = {
        'lat': latitude,
        'lng': longitude,
        'name': name,
        'address': address,
        'build': build,
        'flower': floor,
      };

      await sl<IApiRepository>().post(url: url, formData: FormData.fromMap(data));

      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAddress({
    required int addressID,
  }) async {
    try {
      final String url = EndPoints.deleteAddress(addressID: addressID);

      await sl<IApiRepository>().delete(url: url);

      return;
    } catch (e) {
      rethrow;
    }
  }
}
