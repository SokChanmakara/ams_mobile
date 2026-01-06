import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:dio/dio.dart';

/// Interceptor to handle authentication token refresh automatically
/// When a 401 Unauthorized response is received, it will attempt to refresh
/// the access token using the refresh token and retry the original request
class AuthTokenInterceptor extends Interceptor {
  final Dio _dio;

  AuthTokenInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add access token to requests automatically
    final accessToken = StorageService.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('🔴 Interceptor caught error: ${err.response?.statusCode}');

    // Check if the error is 401 Unauthorized
    if (err.response?.statusCode == 401) {
      print('🔴 Got 401, checking path: ${err.requestOptions.path}');

      // Don't try to refresh for refresh token or logout requests
      if (err.requestOptions.path == BaseUrl.refreshToken ||
          err.requestOptions.path == BaseUrl.logout) {
        print('🔴 This was a refresh token or logout request, clearing auth');
        // Refresh token is invalid or logout failed, clear auth data
        await StorageService.clearAuthData();
        return handler.next(err);
      }

      // Try to refresh the token
      final refreshToken = StorageService.getRefreshToken();
      print(
        '🔴 Refresh token from storage: ${refreshToken != null ? "EXISTS" : "NULL"}',
      );

      if (refreshToken == null || refreshToken.isEmpty) {
        print('🔴 No refresh token, clearing auth');
        // No refresh token available, clear auth and pass the error
        await StorageService.clearAuthData();
        return handler.next(err);
      }

      try {
        print('🟡 Attempting to refresh token...');
        // Create a new Dio instance for the refresh request to avoid interceptor loops
        final refreshDio = Dio(
          BaseOptions(
            baseUrl: _dio.options.baseUrl,
            connectTimeout: _dio.options.connectTimeout,
            receiveTimeout: _dio.options.receiveTimeout,
          ),
        );

        // Make refresh token request
        print('🟡 Calling: ${_dio.options.baseUrl}${BaseUrl.refreshToken}');
        final response = await refreshDio.post(
          BaseUrl.refreshToken,
          data: {'refreshToken': refreshToken},
        );

        print('🟢 Refresh response: ${response.statusCode}');

        if (response.statusCode == 200 && response.data != null) {
          // Extract new tokens from response
          // Response structure: { status: {...}, data: { accessToken, refreshToken, expiresAt, user } }
          final responseData = response.data as Map<String, dynamic>;
          final data = responseData['data'] as Map<String, dynamic>;
          final newAccessToken = data['accessToken'] as String;
          final newRefreshToken = data['refreshToken'] as String;
          final expiresAt = data['expiresAt'] as String;

          print('🟢 Got new tokens, saving...');

          // Save the new tokens
          await StorageService.saveAccessToken(newAccessToken);
          await StorageService.saveRefreshToken(newRefreshToken);
          await StorageService.saveTokenExpiresAt(expiresAt);

          // Save user data if present in response
          if (data.containsKey('user')) {
            final user = data['user'] as Map<String, dynamic>;
            await StorageService.saveUserId(user['id'] as String);
            await StorageService.saveUserEmail(user['email'] as String);
            await StorageService.saveUserName(
              '${user['firstName']} ${user['lastName']}',
            );
            print('🟢 User data updated');
          }

          // Update the global HttpService instance with new token
          HttpService.instance.setAuthToken(newAccessToken);
          print('🟢 Global auth header updated');

          // Update the failed request with the new access token
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          print('🟢 Retrying original request...');

          // Retry the original request with new token
          final options = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          );

          final retryResponse = await _dio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: options,
          );

          print('🟢 Retry succeeded!');
          // Return the successful retry response
          return handler.resolve(retryResponse);
        } else {
          print('🔴 Refresh failed with status: ${response.statusCode}');
          // Refresh failed, clear auth data
          await StorageService.clearAuthData();
          return handler.next(err);
        }
      } catch (refreshError) {
        print('🔴 Refresh error: $refreshError');
        // Refresh failed, clear auth data
        await StorageService.clearAuthData();
        return handler.next(err);
      }
    }

    // For non-401 errors, just pass them through
    super.onError(err, handler);
  }
}
