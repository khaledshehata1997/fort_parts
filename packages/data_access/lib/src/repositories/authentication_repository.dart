import 'package:api_services/api_services.dart';
import 'package:data_access/data_access.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<Map<String, dynamic>> login({
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

      return {
        'status': response.data['status'],
        'type': response.data['data']['type'],
      };
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

  @override
  Future<User> updateProfile({
    required String name,
    required String email,
    required XFile? image,
  }) async {
    try {
      final String url = EndPoints.updateProfile();
      final Map<String, dynamic> data = {
        "name": name,
        "email": email,
      };

      // add nullable parameters
      if (image != null) {
        data.addAll({"image": await MultipartFile.fromFile(image.path)});
      }

      final Response response = await sl<IApiRepository>().post(
        url: url,
        formData: FormData.fromMap(data),
      );

      final User user = User.fromJson(response.data['data']);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> fetchProfile() async {
    try {
      final String url = EndPoints.myProfile();
      final Response response = await sl<IApiRepository>().get(url: url);

      final User user = User.fromJson(response.data['data']);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Notifications> fetchNotifications({
    required int currentPageIndex,
  }) async {
    try {
      final String url = EndPoints.notifications();
      final Map<String, dynamic> data = {'page': currentPageIndex};

      final Response response = await sl<IApiRepository>().get(url: url, queryParameters: data);

      final Notifications notifications = Notifications.fromJson(response.data['data']);
      return notifications;
    } catch (e) {
      rethrow;
    }
  }
}
