import 'package:unified_login/utils/client/result_response.dart';

abstract class Client {
  Future<ResultResponse> get(
    String uri, {
    Map<String, dynamic> query,
    Map<String, dynamic> headers,
  });
  Future<ResultResponse> post(
    String uri,
    dynamic data, {
    Map<String, dynamic> query,
    Map<String, dynamic> headers,
  });
  Future<ResultResponse> put(
    String uri,
    dynamic data, {
    Map<String, dynamic> query,
    Map<String, dynamic> headers,
  });
  Future<ResultResponse> patch(
    String uri,
    dynamic data, {
    Map<String, dynamic> query,
    Map<String, dynamic> headers,
  });
  Future<ResultResponse> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic> headers,
  });

  setHeaders(Map<String, dynamic> headers);
}
