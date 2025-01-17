import 'package:components/components.dart';
import 'package:dio/dio.dart';
import 'package:local_storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      //Fetch Current Access Token
      final String? accessToken = await HiveHelper.get(hiveBox: HiveBoxes.accessToken);

      // Check If User Has Access Token
      if (accessToken != null) {
        options.headers.addAll({'Authorization': 'Bearer $accessToken'});
      }
    } catch (e) {
      rethrow;
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
