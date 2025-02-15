import 'package:data_access/data_access.dart';

abstract class IOrderRepository {
  Future<List<Certificate>> fetchCertificates();

  Future<Certificate> fetchCertificate({
    required int certificateID,
  });

  Future<Orders> fetchOrders({
    required int currentPageIndex,
  });

  Future<OrderDetails> fetchOrder({
    required int orderID,
  });

  Future<void> cancelTask({
    required int taskID,
  });

  Future<void> placeOrder({
    required int addressID,
    required String date,
    required String time,
    required String coupon,
    required String pos,
  });
}
