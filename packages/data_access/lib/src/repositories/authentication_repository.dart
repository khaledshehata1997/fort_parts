import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<bool> login({
    required String phone,
  }) async {
    try {
      final String url = EndPoints.login();
      final Map<String, dynamic> data = {
        "phone": phone,
      };

      final Response response = await sl<IApiRepository>().post(
        url: url,
        formData: FormData.fromMap(data),
      );

      return response.data['status'] == 200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> register({
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

      final Response response = await sl<IApiRepository>().post(
        url: url,
        formData: FormData.fromMap(data),
      );

      return response.data['status'] == 200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoggedUser> otpVerification({
    required String phone,
    required String otp,
  }) async {
    try {
      final String url = EndPoints.otpVerification();
      final Map<String, dynamic> data = {
        "phone": phone,
        "otp": int.parse(otp),
      };
      final Response response = await sl<IApiRepository>().post(
        url: url,
        formData: FormData.fromMap(data),
      );

      final LoggedUser loggedUser = LoggedUser.fromJson(response.data['data']);

      return loggedUser;
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
