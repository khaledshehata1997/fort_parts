import 'package:hive_flutter/hive_flutter.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 2)
class HiveUser {
  const HiveUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String image;
}
