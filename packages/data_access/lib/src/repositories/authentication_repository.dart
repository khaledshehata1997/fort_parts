import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<void> login({
    required String phone,
  }) async {
    try {
      final String url = EndPoints.login();
      final Map<String, dynamic> data = {
        "phone": phone,
      };

      await sl<IApiRepository>().post(
        url: url,
        formData: FormData.fromMap(data),
      );

      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final String url = EndPoints.register();
      final Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "phone": phone,
      };

      await sl<IApiRepository>().post(
        url: url,
        formData: FormData.fromMap(data),
      );

      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> otpVerification({
    required String phone,
    required String otp,
  }) async {
    try {
      final String url = EndPoints.otpVerification();
      final Map<String, dynamic> data = {
        "phone": phone,
        "otp": otp,
      };

      await sl<IApiRepository>().post(
        url: url,
        formData: FormData.fromMap(data),
      );

      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveFCM({
    required String token,
  }) async {
    try {
      final String url = EndPoints.saveFCM();
      final Map<String, dynamic> data = {
        "token": token,
      };

      await sl<IApiRepository>().post(
        url: url,
        formData: FormData.fromMap(data),
      );

      return;
    } catch (e) {
      rethrow;
    }
  }
}
