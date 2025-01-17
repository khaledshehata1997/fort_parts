import 'package:api_services/src/end_points.dart';
import 'package:api_services/src/interceptors/auth_interceptor.dart';
import 'package:api_services/src/interceptors/console_log_interceptor.dart';
import 'package:dio/dio.dart';

class ApiServices {
  static late final Dio _dio;

  static Future<void> init() async {
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
    );
    _dio = Dio(options);
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(ConsoleLogInterceptor());
  }

  // Get Method
  static Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post Method
  static Future<Response> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic rawData,
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        queryParameters: queryParameters,
        data: rawData ?? data ?? formData,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put Method
  static Future<Response> put({
    required String url,
    dynamic rawData,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        queryParameters: queryParameters,
        data: rawData ?? data ?? formData,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete Method
  static Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
