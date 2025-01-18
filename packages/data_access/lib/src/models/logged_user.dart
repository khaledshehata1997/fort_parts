import 'package:data_access/data_access.dart';

class LoggedUser {
  LoggedUser({
    required this.token,
    required this.user,
  });

  final String token;
  final User user;

  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser(
      token: json['token'],
      user: User.fromJson(json['data']),
    );
  }
}
