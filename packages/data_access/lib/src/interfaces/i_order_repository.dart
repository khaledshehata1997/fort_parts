import 'package:data_access/data_access.dart';

abstract class IOrderRepository {
  Future<List<Certificate>> fetchCertificates();

  Future<Certificate> fetchCertificate({
    required int certificateID,
  });

  Future<Orders> fetchOrders({
    required int currentPageIndex,
  });

  Future<Order> fetchOrder({
    required int orderID,
  });
}
