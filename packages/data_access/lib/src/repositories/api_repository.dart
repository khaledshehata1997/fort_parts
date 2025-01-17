import 'package:api_services/api_services.dart';
import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:dio/dio.dart';

class ApiRepository implements IApiRepository {
  @override
  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await ApiServices.get(
        url: url,
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic rawData,
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    try {
      final Response response = await ApiServices.post(
        url: url,
        queryParameters: queryParameters,
        rawData: rawData,
        data: data,
        formData: formData,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> put({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic rawData,
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    try {
      final Response response = await ApiServices.put(
        url: url,
        queryParameters: queryParameters,
        rawData: rawData,
        data: data,
        formData: formData,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await ApiServices.delete(
        url: url,
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
