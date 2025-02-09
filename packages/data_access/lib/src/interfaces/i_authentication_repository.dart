import 'package:data_access/data_access.dart';
import 'package:image_picker/image_picker.dart';

abstract class IAuthenticationRepository {
  Future<Map<String, dynamic>> login({
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

  Future<User> updateProfile({
    required String name,
    required String email,
    required XFile? image,
  });
}
