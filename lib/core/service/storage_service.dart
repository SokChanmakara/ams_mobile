import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing local storage using SharedPreferences
/// Provides type-safe access to stored values
class StorageService {
  StorageService._();

  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  /// Call this in main() before runApp()
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get SharedPreferences instance
  static SharedPreferences get instance {
    if (_prefs == null) {
      throw Exception(
        'StorageService not initialized. Call StorageService.init() in main() before using.',
      );
    }
    return _prefs!;
  }

  // ============================================================================
  // STORAGE KEYS
  // ============================================================================

  static const String _keyThemeMode = 'theme_mode';
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keyLanguageCode = 'language_code';

  // Authentication keys
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserName = 'user_name';
  static const String _keyTokenExpiresAt = 'token_expires_at';
  static const String _keyIsAuthenticated = 'is_authenticated';

  // ============================================================================
  // THEME SETTINGS
  // ============================================================================

  /// Save theme mode (light, dark, system)
  static Future<bool> saveThemeMode(String mode) async {
    return await instance.setString(_keyThemeMode, mode);
  }

  /// Get saved theme mode
  /// Returns 'system' if not set
  static String getThemeMode() {
    return instance.getString(_keyThemeMode) ?? 'system';
  }

  /// Clear theme mode (reset to system default)
  static Future<bool> clearThemeMode() async {
    return await instance.remove(_keyThemeMode);
  }

  // ============================================================================
  // ONBOARDING
  // ============================================================================

  /// Mark onboarding as completed
  static Future<bool> setOnboardingCompleted(bool completed) async {
    return await instance.setBool(_keyOnboardingCompleted, completed);
  }

  /// Check if onboarding is completed
  static bool isOnboardingCompleted() {
    return instance.getBool(_keyOnboardingCompleted) ?? false;
  }

  // ============================================================================
  // LANGUAGE SETTINGS
  // ============================================================================

  /// Save language code (e.g., 'en', 'ar', 'fr')
  static Future<bool> saveLanguageCode(String code) async {
    return await instance.setString(_keyLanguageCode, code);
  }

  /// Get saved language code
  static String? getLanguageCode() {
    return instance.getString(_keyLanguageCode);
  }

  // ============================================================================
  // AUTHENTICATION
  // ============================================================================

  /// Save access token
  static Future<bool> saveAccessToken(String token) async {
    return await instance.setString(_keyAccessToken, token);
  }

  /// Get access token
  static String? getAccessToken() {
    return instance.getString(_keyAccessToken);
  }

  /// Save refresh token
  static Future<bool> saveRefreshToken(String token) async {
    return await instance.setString(_keyRefreshToken, token);
  }

  /// Get refresh token
  static String? getRefreshToken() {
    return instance.getString(_keyRefreshToken);
  }

  /// Save user ID
  static Future<bool> saveUserId(String userId) async {
    return await instance.setString(_keyUserId, userId);
  }

  /// Get user ID
  static String? getUserId() {
    return instance.getString(_keyUserId);
  }

  /// Save user email
  static Future<bool> saveUserEmail(String email) async {
    return await instance.setString(_keyUserEmail, email);
  }

  /// Get user email
  static String? getUserEmail() {
    return instance.getString(_keyUserEmail);
  }

  /// Save user name
  static Future<bool> saveUserName(String name) async {
    return await instance.setString(_keyUserName, name);
  }

  /// Get user name
  static String? getUserName() {
    return instance.getString(_keyUserName);
  }

  /// Save token expiration timestamp
  static Future<bool> saveTokenExpiresAt(String expiresAt) async {
    return await instance.setString(_keyTokenExpiresAt, expiresAt);
  }

  /// Get token expiration timestamp
  static String? getTokenExpiresAt() {
    return instance.getString(_keyTokenExpiresAt);
  }

  /// Set authentication status
  static Future<bool> setAuthenticated(bool isAuthenticated) async {
    return await instance.setBool(_keyIsAuthenticated, isAuthenticated);
  }

  /// Check if user is authenticated
  static bool isAuthenticated() {
    return instance.getBool(_keyIsAuthenticated) ?? false;
  }

  /// Clear all authentication data
  static Future<void> clearAuthData() async {
    await instance.remove(_keyAccessToken);
    await instance.remove(_keyRefreshToken);
    await instance.remove(_keyUserId);
    await instance.remove(_keyUserEmail);
    await instance.remove(_keyUserName);
    await instance.remove(_keyTokenExpiresAt);
    await instance.setBool(_keyIsAuthenticated, false);
  }

  // ============================================================================
  // GENERIC METHODS
  // ============================================================================

  /// Save string value
  static Future<bool> setString(String key, String value) async {
    return await instance.setString(key, value);
  }

  /// Get string value
  static String? getString(String key) {
    return instance.getString(key);
  }

  /// Save int value
  static Future<bool> setInt(String key, int value) async {
    return await instance.setInt(key, value);
  }

  /// Get int value
  static int? getInt(String key) {
    return instance.getInt(key);
  }

  /// Save bool value
  static Future<bool> setBool(String key, bool value) async {
    return await instance.setBool(key, value);
  }

  /// Get bool value
  static bool? getBool(String key) {
    return instance.getBool(key);
  }

  /// Save double value
  static Future<bool> setDouble(String key, double value) async {
    return await instance.setDouble(key, value);
  }

  /// Get double value
  static double? getDouble(String key) {
    return instance.getDouble(key);
  }

  /// Save string list
  static Future<bool> setStringList(String key, List<String> value) async {
    return await instance.setStringList(key, value);
  }

  /// Get string list
  static List<String>? getStringList(String key) {
    return instance.getStringList(key);
  }

  /// Check if key exists
  static bool containsKey(String key) {
    return instance.containsKey(key);
  }

  /// Remove a key
  static Future<bool> remove(String key) async {
    return await instance.remove(key);
  }

  /// Clear all stored data
  static Future<bool> clearAll() async {
    return await instance.clear();
  }

  /// Get all keys
  static Set<String> getAllKeys() {
    return instance.getKeys();
  }
}
