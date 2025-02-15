import 'package:data_access/data_access.dart';

class Task {
  Task({
    required this.id,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.notes,
    required this.product,
    required this.provider,
  });

  final int id;
  final String date;
  final String status;
  final String statusColor;
  final String notes;
  final Product product;
  final Provider provider;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      date: json['date'],
      status: json['status'],
      statusColor: json[''] ?? '028602',
      notes: json['notes'],
      product: Product.fromJson(json['product']),
      provider: Provider.fromJson(json['provider']),
    );
  }
}
