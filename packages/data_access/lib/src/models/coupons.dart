class Coupons {
  Coupons({
    required this.active,
    required this.expired,
  });

  final List<Coupon> active;
  final List<Coupon> expired;

  factory Coupons.fromJson(Map<String, dynamic> json) {
    return Coupons(
      active: List<Coupon>.from(json['active'].map((x) => Coupon.fromJson(x))),
      expired: List<Coupon>.from(json['end'].map((x) => Coupon.fromJson(x))),
    );
  }
}

class Coupon {
  Coupon({
    required this.id,
    required this.title,
    required this.code,
    required this.type,
    required this.value,
    required this.expiryDate,
    required this.image,
    required this.isActive,
  });

  final int id;
  final String title;
  final String code;
  final String type;
  final int value;
  final String expiryDate;
  final String image;
  final bool isActive;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      title: json['title'],
      code: json['code'],
      type: json['type'],
      value: json['value'],
      expiryDate: json['end_date'],
      image: json['image'],
      isActive: json['active_coupon'] == 1,
    );
  }
}
