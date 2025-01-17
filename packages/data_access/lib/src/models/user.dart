class User {
  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  final String name;
  final String email;
  final String phone;
  final String image;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
    );
  }
}
