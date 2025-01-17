import 'package:hive_flutter/hive_flutter.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 2)
class HiveUser {
  const HiveUser({
    required this.id,
  });

  @HiveField(0)
  final String id;
}
