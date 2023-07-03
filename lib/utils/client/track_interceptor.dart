import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/material.dart';

class TrackInterceptor implements InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("REQUEST[${options.method}] => PATH: ${options.path}");
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    handler.reject(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}");
    handler.resolve(response);
  }
}
