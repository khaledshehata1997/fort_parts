import 'package:data_access/src/models/logged_user.dart';

abstract class IAuthenticationRepository {
  Future<bool> login({
    required String phone,
  });

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
  });

  Future<LoggedUser> otpVerification({
    required String phone,
    required String otp,
  });

  Future<void> saveFCM({
    required String token,
  });
}
