import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:flutter/material.dart';

/// Service to check and manage authentication state
class AuthStateService {
  /// Check if user is authenticated on app startup
  /// Returns true if user has valid tokens
  static Future<bool> checkAuthState() async {
    try {
      debugPrint('\n🔐 Checking authentication state...');

      // Check if user was previously authenticated
      final isAuthenticated = StorageService.isAuthenticated();
      debugPrint('   Was authenticated: $isAuthenticated');

      if (!isAuthenticated) {
        debugPrint('   ❌ Not authenticated\n');
        return false;
      }

      // Get stored tokens
      final accessToken = StorageService.getAccessToken();
      final refreshToken = StorageService.getRefreshToken();

      debugPrint('   Access Token: ${accessToken != null ? "EXISTS" : "NULL"}');
      debugPrint(
        '   Refresh Token: ${refreshToken != null ? "EXISTS" : "NULL"}',
      );

      // If no tokens, user needs to login
      if (accessToken == null || refreshToken == null) {
        debugPrint('   ❌ No tokens found\n');
        await StorageService.clearAuthData();
        return false;
      }

      // Set the access token in HTTP headers
      HttpService.instance.setAuthToken(accessToken);
      debugPrint('   ✅ Auth token set in HTTP headers');

      // Check if token is expired by trying to validate it
      final expiresAt = StorageService.getTokenExpiresAt();
      debugPrint('   Token expires at: ${expiresAt ?? "Unknown"}');

      if (expiresAt != null) {
        final expiryDate = DateTime.parse(expiresAt);
        final now = DateTime.now();

        if (expiryDate.isBefore(now)) {
          debugPrint(
            '   ⚠️  Access token expired, will refresh on first API call',
          );
        } else {
          debugPrint('   ✅ Access token still valid');
        }
      }

      debugPrint('   ✅ User authenticated\n');
      return true;
    } catch (e) {
      debugPrint('   ❌ Error checking auth state: $e\n');
      await StorageService.clearAuthData();
      return false;
    }
  }

  /// Manually refresh tokens if needed
  /// Returns true if refresh was successful
  static Future<bool> refreshTokensIfNeeded() async {
    try {
      final refreshToken = StorageService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      debugPrint('🔄 Refreshing tokens...');

      final response = await HttpService.instance.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data as Map<String, dynamic>;
        final status = responseData['status'] as Map<String, dynamic>;
        final data = responseData['data'] as Map<String, dynamic>;

        if (status['isSuccess'] == true) {
          // Save new tokens
          await StorageService.saveAccessToken(data['accessToken'] as String);
          await StorageService.saveRefreshToken(data['refreshToken'] as String);
          await StorageService.saveTokenExpiresAt(data['expiresAt'] as String);

          // Update HTTP headers
          HttpService.instance.setAuthToken(data['accessToken'] as String);

          debugPrint('✅ Tokens refreshed successfully\n');
          return true;
        }
      }

      debugPrint('❌ Token refresh failed\n');
      return false;
    } catch (e) {
      debugPrint('❌ Error refreshing tokens: $e\n');
      return false;
    }
  }

  /// Clear authentication and logout
  static Future<void> logout() async {
    await StorageService.clearAuthData();
    HttpService.instance.removeAuthToken();
    debugPrint('🔓 User logged out\n');
  }
}
