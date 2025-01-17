import 'package:dio/dio.dart';

abstract class IApiRepository {
  Future<Response> get({
    required String url,
    Map<String, dynamic> queryParameters,
  });

  Future<Response> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic rawData,
    Map<String, dynamic>? data,
    FormData? formData,
  });

  Future<Response> put({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic rawData,
    Map<String, dynamic>? data,
    FormData? formData,
  });

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
  });
}
