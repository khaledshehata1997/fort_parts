class User {
  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.activeCoupon,
    required this.pos,
    required this.posUsed,
  });

  final String name;
  final String email;
  final String phone;
  final String image;
  final String activeCoupon;
  final int pos;
  final int posUsed;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      activeCoupon: json['active_coupon'],
      pos: json['pos'],
      posUsed: json['pos_used'],
    );
  }
}
