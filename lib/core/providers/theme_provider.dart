import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme mode notifier
/// Manages theme mode changes and persists to storage
class ThemeModeNotifier extends Notifier<ThemeMode> {
  /// Load initial theme mode from storage
  ThemeMode _loadInitialThemeMode() {
    final savedMode = StorageService.getThemeMode();
    return _stringToThemeMode(savedMode);
  }

  /// Convert string to ThemeMode
  ThemeMode _stringToThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Convert ThemeMode to string
  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  @override
  ThemeMode build() {
    return _loadInitialThemeMode();
  }

  /// Set theme mode and persist to storage
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await StorageService.saveThemeMode(_themeModeToString(mode));
  }

  /// Toggle between light and dark mode
  /// If current mode is system, it toggles to light
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }

  /// Set light theme
  Future<void> setLightMode() async {
    await setThemeMode(ThemeMode.light);
  }

  /// Set dark theme
  Future<void> setDarkMode() async {
    await setThemeMode(ThemeMode.dark);
  }

  /// Set system theme (follow device settings)
  Future<void> setSystemMode() async {
    await setThemeMode(ThemeMode.system);
  }

  /// Check if current mode is dark
  /// Takes into account system theme if mode is system
  bool isDarkMode(BuildContext context) {
    if (state == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return state == ThemeMode.dark;
  }

  /// Check if current mode is light
  /// Takes into account system theme if mode is system
  bool isLightMode(BuildContext context) {
    if (state == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.light;
    }
    return state == ThemeMode.light;
  }

  /// Check if following system theme
  bool isSystemMode() {
    return state == ThemeMode.system;
  }
}

/// Provider for theme mode
/// Use this to access and modify the app's theme mode
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Convenience provider to check if dark mode is active
/// Usage: final isDark = ref.watch(isDarkModeProvider);
final isDarkModeProvider = Provider<bool>((ref) {
  final mode = ref.watch(themeModeProvider);
  // Note: This doesn't account for system theme
  // Use ThemeModeNotifier.isDarkMode(context) for accurate result
  return mode == ThemeMode.dark;
});

/// Convenience provider to check if light mode is active
final isLightModeProvider = Provider<bool>((ref) {
  final mode = ref.watch(themeModeProvider);
  return mode == ThemeMode.light;
});

/// Convenience provider to check if system mode is active
final isSystemModeProvider = Provider<bool>((ref) {
  final mode = ref.watch(themeModeProvider);
  return mode == ThemeMode.system;
});
