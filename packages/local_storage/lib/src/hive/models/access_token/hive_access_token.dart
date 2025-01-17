import 'package:hive_flutter/hive_flutter.dart';

part 'hive_access_token.g.dart';

@HiveType(typeId: 1)
class HiveAccessToken {
  const HiveAccessToken({
    required this.accessToken,
  });

  @HiveField(0)
  final String accessToken;
}
