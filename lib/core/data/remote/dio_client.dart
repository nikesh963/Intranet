import 'package:dio/dio.dart';

import '../apiEndpoints/api_endpoints.dart';
import '../local/local_preference.dart';
import 'authentication_interceptor.dart';

class DioClient {
  final LocalPreference preference;

  // dio instance
  final Dio dio;

  // receiveTimeout
  final Duration receiveTimeout = const Duration(seconds: 60);

  // connectTimeout
  final Duration connectionTimeout = const Duration(seconds: 30);

  // injecting dio instance
  DioClient({required this.dio, required this.preference}) {
    dio
      ..options.baseUrl = APIEndpoint.baseUrl
      ..options.connectTimeout = connectionTimeout
      ..options.receiveTimeout = receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ))
      ..interceptors.add(AuthenticationInterceptor(dio, preference))
      ..options.validateStatus = (_) => true;
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String uri, {
    data,
  }) async {
    try {
      final Response response = await dio.post(
        uri,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final Response response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
