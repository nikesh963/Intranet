import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AppLogger.dart';
import '../dataBaseHelper/SharedPrefHelper.dart';

class ApiHelper {
  final Dio _dio;
  // static String get BASEURL => dotenv.env['BASE_URL'] ?? "";
  static String get BASEURL => "https://intranet.techappsworld.com/api";
  static String get REFRESH_URL => dotenv.env['REFRESH_URL'] ?? "";

  ApiHelper()
      : _dio = Dio(BaseOptions(
          baseUrl: BASEURL,
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
      final loginDetails = await SharedPrefHelper.getLoginDetails();
      final token = loginDetails['token'];
      if (token != null && token.isNotEmpty) {
        AppLogger.debug("🔐 Attaching token: $token");
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    }, onResponse: (response, handler) {
      handler.next(response);
    }, onError: (DioError e, handler) async {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;

      String? errorCode;
      if (responseData is Map<String, dynamic>) {
        errorCode = responseData['code'];
      }

      final isTokenExpired = statusCode == 401 &&
          (errorCode == 'token_not_valid' ||
              responseData.toString().toLowerCase().contains("invalid token") ||
              responseData.toString().toLowerCase().contains("expired token") ||
              responseData.toString().toLowerCase().contains("token"));

      if (isTokenExpired) {
        AppLogger.debug("⚠️ Token expired. Attempting refresh...");

        final retried = e.requestOptions.headers['retry'] == true;
        if (!retried) {
          final refreshed = await refreshAccessToken();
          if (refreshed) {
            final loginDetails = await SharedPrefHelper.getLoginDetails();
            final newToken = loginDetails['token'];

            final RequestOptions requestOptions = e.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newToken';
            requestOptions.headers['retry'] = true;
            _dio.options.headers['Authorization'] = 'Bearer $newToken';

            try {
              final response = await _dio.fetch(requestOptions);
              return handler.resolve(response);
            } catch (err) {
              return handler.reject(err as DioError);
            }
          } else {
            AppLogger.error("❌ Failed to refresh token. Logging out...");
            return handler.reject(e);
          }
        }
      }
      handler.next(e); // Let it fall through if it's not a token issue
    }
        ));
  }

  Future<bool> refreshAccessToken() async {
    try {
      final loginDetails = await SharedPrefHelper.getLoginDetails();
      final refreshToken = loginDetails['refreshToken'];

      if (refreshToken != null && refreshToken.isNotEmpty) {
        AppLogger.debug("🔄 Using refreshToken: $refreshToken");

        final refreshDio = Dio();
        final refreshResponse = await refreshDio.post(
          REFRESH_URL,
          data: {'refresh_token': refreshToken},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

        final data = refreshResponse.data;
        AppLogger.debug("🔁 Refresh response: $data");

        final newAccessToken = data['access'];
        final newRefreshToken = data['refresh'];

        if (newAccessToken != null && newRefreshToken != null) {
          // Save both tokens
          await SharedPrefHelper.saveAccessToken(newAccessToken);
          await SharedPrefHelper.saveRefreshToken(newRefreshToken);
          AppLogger.debug("✅ Access and Refresh tokens updated successfully.");
          return true;
        } else {
          AppLogger.error("❌ Refresh or access token missing in response.");
          return false;
        }
      } else {
        AppLogger.error("🔴 No refresh token found.");
        return false;
      }
    } catch (e) {
      AppLogger.error("🔴 Refresh token failed: $e");
      return false;
    }
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      AppLogger.debug("API: $BASEURL$endpoint");
      AppLogger.debug("request:$endpoint: $queryParameters");
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      AppLogger.debug("response:$endpoint ${response.data}");
      return response;
    } on DioError catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      AppLogger.debug("API: $BASEURL$endpoint");
      AppLogger.debug("request:$endpoint: $data");
      final response = await _dio.post(endpoint, data: data);
      AppLogger.debug("response:$endpoint ${response.data}");
      AppLogger.debug("response code:$endpoint ${response.statusCode}");
      return response;
    } on DioError catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> postFormData(String endpoint, dio.FormData formData) async {
    try {
      AppLogger.debug("API (multipart): $BASEURL$endpoint");
      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      AppLogger.debug("response:$endpoint ${response.data}");
      return response;
    } on DioError catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioError e) {
    AppLogger.error("❌ Dio error: ${e.message}");
    if (e.response != null) {
      AppLogger.error("❌ Status Code: ${e.response?.statusCode}");
      AppLogger.error("❌ Response Type: ${e.response?.data.runtimeType}");
      AppLogger.error("❌ Data: ${e.response?.data}");
    }
  }

  Future<File> urlToFileWithDio(String imageUrl) async {
    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();

    // Create a unique file name
    final fileName = imageUrl.split('/').last;

    // The file path where the image will be saved
    final filePath = '${tempDir.path}/$fileName';

    // Download the file using Dio
    final dio = Dio();
    await dio.download(imageUrl, filePath);

    return File(filePath);
  }


}
