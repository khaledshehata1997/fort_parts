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

  @override
  Future<Certificate> fetchCertificate({
    required int certificateID,
  }) async {
    try {
      final String url = EndPoints.certificateDetails(certificateID: certificateID);

      final Response response = await sl<IApiRepository>().get(url: url);

      final Certificate certificate = Certificate.fromJson(response.data['data']);

      return certificate;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Orders> fetchOrders({
    required int currentPageIndex,
  }) async {
    try {
      final String url = EndPoints.myOrders();
      final Map<String, dynamic> data = {'page': currentPageIndex};

      final Response response = await sl<IApiRepository>().get(
        url: url,
        queryParameters: data,
      );

      final Orders orders = Orders.fromJson(response.data['data']);
      return orders;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Order> fetchOrder({
    required int orderID,
  }) async {
    try {
      final String url = EndPoints.orderDetails(orderID: orderID);

      final Response response = await sl<IApiRepository>().get(url: url);

      final Order order = Order.fromJson(response.data['data']);

      return order;
    } catch (e) {
      rethrow;
    }
  }
}
