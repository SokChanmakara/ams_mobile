import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
    // Don't add auth token to logout requests (they might have expired tokens)
    if (options.path == BaseUrl.logout) {
      return super.onRequest(options, handler);
    }

    // Add access token to requests automatically
    final accessToken = StorageService.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('🔴 Interceptor caught error: ${err.response?.statusCode}');

    // Check if the error is 401 Unauthorized
    if (err.response?.statusCode == 401) {
      debugPrint('🔴 Got 401, checking path: ${err.requestOptions.path}');

      // Don't try to refresh for refresh token, logout, or change-password requests
      // For change-password, 401 means wrong current password, not expired token
      if (err.requestOptions.path == BaseUrl.refreshToken ||
          err.requestOptions.path == BaseUrl.logout ||
          err.requestOptions.path == BaseUrl.changePassword) {
        debugPrint(
          '🔴 This was a refresh token, logout, or change-password request',
        );
        // For change-password, pass the error through without clearing auth
        if (err.requestOptions.path == BaseUrl.changePassword) {
          debugPrint('🔴 Change password failed - wrong current password');
          return handler.next(err);
        }
        // For refresh token or logout, clear auth data
        debugPrint('🔴 Clearing auth data');
        await StorageService.clearAuthData();
        return handler.next(err);
      }

      // Try to refresh the token
      final refreshToken = StorageService.getRefreshToken();
      debugPrint(
        '🔴 Refresh token from storage: ${refreshToken != null ? "EXISTS" : "NULL"}',
      );

      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint('🔴 No refresh token, clearing auth');
        // No refresh token available, clear auth and pass the error
        await StorageService.clearAuthData();
        return handler.next(err);
      }

      try {
        debugPrint('🟡 Attempting to refresh token...');
        // Create a new Dio instance for the refresh request to avoid interceptor loops
        final refreshDio = Dio(
          BaseOptions(
            baseUrl: _dio.options.baseUrl,
            connectTimeout: _dio.options.connectTimeout,
            receiveTimeout: _dio.options.receiveTimeout,
          ),
        );

        // Make refresh token request
        debugPrint(
          '🟡 Calling: ${_dio.options.baseUrl}${BaseUrl.refreshToken}',
        );
        final response = await refreshDio.post(
          BaseUrl.refreshToken,
          data: {'refreshToken': refreshToken},
        );

        debugPrint('🟢 Refresh response: ${response.statusCode}');

        if (response.statusCode == 200 && response.data != null) {
          // Extract new tokens from response
          // Response structure: { status: {...}, data: { accessToken, refreshToken, expiresAt, user } }
          final responseData = response.data as Map<String, dynamic>;
          final data = responseData['data'] as Map<String, dynamic>;
          final newAccessToken = data['accessToken'] as String;
          final newRefreshToken = data['refreshToken'] as String;
          final expiresAt = data['expiresAt'] as String;

          debugPrint('🟢 Got new tokens, saving...');

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
            debugPrint('🟢 User data updated');
          }

          // Update the global HttpService instance with new token
          HttpService.instance.setAuthToken(newAccessToken);
          debugPrint('🟢 Global auth header updated');

          // Update the failed request with the new access token
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          debugPrint('🟢 Retrying original request...');

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

          debugPrint('🟢 Retry succeeded!');
          // Return the successful retry response
          return handler.resolve(retryResponse);
        } else {
          debugPrint('🔴 Refresh failed with status: ${response.statusCode}');
          // Refresh failed, clear auth data
          await StorageService.clearAuthData();
          return handler.next(err);
        }
      } catch (refreshError) {
        debugPrint('🔴 Refresh error: $refreshError');
        // Refresh failed, clear auth data
        await StorageService.clearAuthData();
        return handler.next(err);
      }
    }

    // For non-401 errors, just pass them through
    super.onError(err, handler);
  }
}
