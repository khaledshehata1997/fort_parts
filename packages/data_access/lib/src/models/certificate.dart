import 'package:data_access/data_access.dart';

class Certificate {
  Certificate({
    required this.id,
    required this.code,
    required this.startDate,
    required this.endDate,
    required this.procedure,
    required this.problem,
    required this.type,
    required this.brand,
    required this.product,
  });

  final int id;
  final String code;
  final String startDate;
  final String endDate;
  final String procedure;
  final String problem;
  final String type;
  final String brand;
  final Product product;

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'],
      code: json['code'],
      startDate: json['start_certificate'],
      endDate: json['end_certificate'],
      procedure: json['procedure'],
      problem: json['problem'],
      type: json['type']['title'],
      brand: json['brand']['title'],
      product: Product.fromJson(json['product']),
    );
  }
}
