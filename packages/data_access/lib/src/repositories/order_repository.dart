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
  Future<OrderDetails> fetchOrder({
    required int orderID,
  }) async {
    try {
      final String url = EndPoints.orderDetails(orderID: orderID);

      final Response response = await sl<IApiRepository>().get(url: url);

      final OrderDetails order = OrderDetails.fromJson(response.data['data']);

      return order;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancelTask({
    required int taskID,
  }) async {
    try {
      final String url = EndPoints.cancelTask();
      final Map<String, dynamic> data = {'id': taskID};

      await sl<IApiRepository>().post(url: url, rawData: data);

      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> placeOrder({
    required int addressID,
    required String date,
    required String time,
    required String coupon,
    required String pos,
  }) async {
    try {
      final String url = EndPoints.placeOrder();
      final Map<String, dynamic> data = {
        "address_id": addressID,
        "date": date,
        "time": time,
        "coupon": coupon,
        "pos": pos,
        "payment_method": "cache_delivery"
      };

      await sl<IApiRepository>().post(url: url, rawData: data);

      return;
    } catch (e) {
      rethrow;
    }
  }
}
