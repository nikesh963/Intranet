import 'dart:io';
import 'package:dio/dio.dart';

import '../local/local_preference.dart';

class AuthenticationInterceptor extends InterceptorsWrapper {
  final Dio dio;
  final LocalPreference preference;

  AuthenticationInterceptor(this.dio, this.preference);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Set the Accept header to JSON
    options.headers['Accept'] = ContentType.json;

    // Fetch the authorization token from local storage
    final accessToken = await preference.getAccessToken();
    final role = await preference.getRole();

    if (accessToken != null) {
      if (role == "Partner") {
        options.headers['Authorization'] = "Bearer $accessToken";
      } else {
        options.headers['Authorization'] = accessToken;
      }
    }

    return handler.next(options);
  }

  @override
  Future onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    // Check if the response status is 401 (unauthorized)
    if (response.statusCode == 401) {
      return handler.resolve(await dio.fetch(response.requestOptions));
    } else {
      return handler.next(response);
    }
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the response status is 401 (unauthorized)
    if (err.response?.statusCode == 401) {
      // Perform token refresh logic
      // Call your API to refresh the token
      // final newAccessToken = await fetchRefreshToken();
      // preference.setAccessToken(newAccessToken);

      // Update the access token in the headers
      // err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

      // Retry the original request with the new access token
      // return dio.fetch(err.requestOptions);
      return handler.resolve(await dio.fetch(err.requestOptions));
    } else {
      return handler.next(err);
    }
  }
}
