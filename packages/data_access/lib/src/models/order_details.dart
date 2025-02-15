import 'package:data_access/data_access.dart';
import 'package:data_access/src/models/spart_part.dart';

class OrderDetails {
  OrderDetails({
    required this.id,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.products,
    required this.tasks,
    required this.spareParts,
    required this.subTotal,
    required this.sparePrice,
    required this.total,
  });

  final int id;
  final String date;
  final String status;
  final String statusColor;
  final List<Product> products;
  final List<Task> tasks;
  final List<SparePart> spareParts;
  final int subTotal;
  final int sparePrice;
  final int total;

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      date: json['data'],
      status: json['status'],
      statusColor: json['color_status'],
      products: List<Product>.from(json['products'].map((x) => Product.fromJson(x['product']))),
      tasks: List<Task>.from(json['tasks'].map((x) => Task.fromJson(x))),
      spareParts: List<SparePart>.from(json['spear'].map((x) => SparePart.fromJson(x))),
      subTotal: json['sub_total'],
      sparePrice: json['spare_price'],
      total: json['total'],
    );
  }
}
