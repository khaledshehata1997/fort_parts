abstract class IAuthenticationRepository {
  Future<void> login({
    required String phone,
  });

  Future<void> register({
    required String name,
    required String email,
    required String phone,
  });

  Future<void> otpVerification({
    required String phone,
    required String otp,
  });

  Future<void> saveFCM({
    required String token,
  });
}
