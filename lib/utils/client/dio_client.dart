import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:unified_login/utils/client/client_interface.dart';
import 'package:unified_login/utils/client/result_response.dart';

class DioClient extends Client {
  late Dio _dio;

  DioClient(String baseUrl, {List<InterceptorsWrapper> interceptors = const [], int receiveTimeout = 40000}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {"Content-type": "application/json"},
        connectTimeout: const Duration(seconds: 10000),
        receiveTimeout: Duration(seconds: receiveTimeout),
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    _dio.interceptors.addAll(interceptors);
  }

  @override
  Future<ResultResponse> get(String uri, {Map<String, dynamic> query = const {}, Map<String, dynamic> headers = const {}}) async {
    final result = await _dio.get(uri, queryParameters: query, options: Options(headers: headers));

    return ResultResponse(result.data, statusCode: result.statusCode);
  }

  @override
  Future<ResultResponse> post(String uri, dynamic data, {Map<String, dynamic> query = const {}, Map<String, dynamic> headers = const {}}) async {
    final result = await _dio.post(uri, queryParameters: query, data: data, options: Options(headers: headers));

    return ResultResponse(result.data, statusCode: result.statusCode);
  }

  @override
  Future<ResultResponse> put(String uri, dynamic data, {Map<String, dynamic> query = const {}, Map<String, dynamic> headers = const {}}) async {
    final result = await _dio.put(uri, queryParameters: query, data: data, options: Options(headers: headers));

    return ResultResponse(result.data, statusCode: result.statusCode);
  }

  @override
  Future<ResultResponse> patch(String uri, data, {Map<String, dynamic> query = const {}, Map<String, dynamic> headers = const {}}) async {
    final result = await _dio.patch(uri, queryParameters: query, data: data, options: Options(headers: headers));

    return ResultResponse(result.data, statusCode: result.statusCode);
  }

  @override
  Future<ResultResponse> delete(String uri, {dynamic data, Map<String, dynamic> headers = const {}}) async {
    final result = await _dio.delete(uri, options: Options(headers: headers));

    return ResultResponse(result.data, statusCode: result.statusCode);
  }

  @override
  setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }
}
