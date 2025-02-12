import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class OrderRepository implements IOrderRepository {
  @override
  Future<List<Certificate>> fetchCertificates() async {
    try {
      final String url = EndPoints.myCertificates();

      final Response response = await sl<IApiRepository>().get(url: url);

      final List<Certificate> certificates = List<Certificate>.from(response.data['data'].map((x) => Certificate.fromJson(x)));

      return certificates;
    } catch (e) {
      rethrow;
    }
  }
}
