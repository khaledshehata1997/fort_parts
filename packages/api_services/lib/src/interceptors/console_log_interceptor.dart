import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ConsoleLogInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));
      logger.i([
        "Path: ${response.requestOptions.path}",
        "Headers: ${response.requestOptions.headers}",
        "QueryParameters: ${response.requestOptions.queryParameters}",
        "Data: ${response.requestOptions.data}",
        "Status Code: ${response.statusCode}",
        "Response: ${response.data}",
      ]);
    } catch (e) {
      rethrow;
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));
      logger.e([
        "Path: ${err.requestOptions.path}",
        "Headers: ${err.requestOptions.headers}",
        "QueryParameters: ${err.requestOptions.queryParameters}",
        "Data: ${err.requestOptions.data}",
        "Error: ${err.error}",
        "Response: ${err.response}",
      ]);
    } catch (e) {
      rethrow;
    }
    handler.next(err);
  }
}
