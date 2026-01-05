import 'package:flutter/material.dart';

/// App color system with light and dark theme support
/// Usage: AppColors.primary, AppColors.background(context)
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ============================================================================
  // PRIMARY COLORS
  // ============================================================================

  /// Main brand color - Blue
  static const Color primary = Color(0xFF137FEC);

  /// Darker shade of primary (for hover states)
  static const Color primaryDark = Color(0xFF0E5FBF);

  /// Lighter shade of primary
  static const Color primaryLight = Color(0xFF4D9FEF);

  /// Very light primary (for backgrounds)
  static const Color primarySurface = Color(0xFFE8F3FE);

  // ============================================================================
  // BACKGROUND COLORS
  // ============================================================================

  /// Main background color (context-aware)
  static Color background(BuildContext context) {
    return isDark(context) ? backgroundDark : backgroundLight;
  }

  /// Light mode background
  static const Color backgroundLight = Color(0xFFF6F7F8);

  /// Dark mode background
  static const Color backgroundDark = Color(0xFF101922);

  // ============================================================================
  // SURFACE COLORS (Cards, Containers)
  // ============================================================================

  /// Surface color (context-aware)
  static Color surface(BuildContext context) {
    return isDark(context) ? surfaceDark : surfaceLight;
  }

  /// Light mode surface
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Dark mode surface
  static const Color surfaceDark = Color(0xFF1E293B);

  /// Elevated surface (slightly lighter)
  static Color surfaceElevated(BuildContext context) {
    return isDark(context) ? const Color(0xFF2D3748) : const Color(0xFFFFFFFF);
  }

  // ============================================================================
  // TEXT COLORS
  // ============================================================================

  /// Primary text color (context-aware)
  static Color textPrimary(BuildContext context) {
    return isDark(context) ? textPrimaryDark : textPrimaryLight;
  }

  /// Light mode primary text
  static const Color textPrimaryLight = Color(0xFF0F172A);

  /// Dark mode primary text
  static const Color textPrimaryDark = Color(0xFFFFFFFF);

  /// Secondary text color (context-aware)
  static Color textSecondary(BuildContext context) {
    return isDark(context) ? textSecondaryDark : textSecondaryLight;
  }

  /// Light mode secondary text
  static const Color textSecondaryLight = Color(0xFF64748B);

  /// Dark mode secondary text
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  /// Tertiary/hint text color (context-aware)
  static Color textTertiary(BuildContext context) {
    return isDark(context) ? textTertiaryDark : textTertiaryLight;
  }

  /// Light mode tertiary text
  static const Color textTertiaryLight = Color(0xFF94A3B8);

  /// Dark mode tertiary text
  static const Color textTertiaryDark = Color(0xFF64748B);

  /// Disabled text color (context-aware)
  static Color textDisabled(BuildContext context) {
    return isDark(context) ? const Color(0xFF475569) : const Color(0xFFCBD5E1);
  }

  // ============================================================================
  // BORDER COLORS
  // ============================================================================

  /// Border color (context-aware)
  static Color border(BuildContext context) {
    return isDark(context) ? borderDark : borderLight;
  }

  /// Light mode border
  static const Color borderLight = Color(0xFFE2E8F0);

  /// Dark mode border
  static const Color borderDark = Color(0xFF334155);

  /// Focused border color
  static const Color borderFocused = primary;

  // ============================================================================
  // SEMANTIC COLORS
  // ============================================================================

  /// Success color
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF065F46);

  /// Error color
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFF991B1B);

  /// Warning color
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFF92400E);

  /// Info color
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDCEEFE);
  static const Color infoDark = Color(0xFF1E3A8A);

  // ============================================================================
  // ICON COLORS
  // ============================================================================

  /// Default icon color (context-aware)
  static Color icon(BuildContext context) {
    return isDark(context) ? iconDark : iconLight;
  }

  /// Light mode icon
  static const Color iconLight = Color(0xFF94A3B8);

  /// Dark mode icon
  static const Color iconDark = Color(0xFF94A3B8);

  /// Active/focused icon color
  static const Color iconActive = primary;

  // ============================================================================
  // DIVIDER COLORS
  // ============================================================================

  /// Divider color (context-aware)
  static Color divider(BuildContext context) {
    return isDark(context) ? dividerDark : dividerLight;
  }

  /// Light mode divider
  static const Color dividerLight = Color(0xFFE2E8F0);

  /// Dark mode divider
  static const Color dividerDark = Color(0xFF334155);

  // ============================================================================
  // SHADOW COLORS
  // ============================================================================

  /// Shadow color (context-aware)
  static Color shadow(BuildContext context) {
    return isDark(context)
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.black.withValues(alpha: 0.1);
  }

  /// Light shadow
  static Color shadowLight = Colors.black.withValues(alpha: 0.03);

  /// Medium shadow
  static Color shadowMedium = Colors.black.withValues(alpha: 0.1);

  /// Strong shadow
  static Color shadowStrong = Colors.black.withValues(alpha: 0.2);

  // ============================================================================
  // OVERLAY COLORS
  // ============================================================================

  /// Overlay for dialogs, bottom sheets (context-aware)
  static Color overlay(BuildContext context) {
    return isDark(context)
        ? Colors.black.withValues(alpha: 0.6)
        : Colors.black.withValues(alpha: 0.4);
  }

  /// Ripple/splash color (context-aware)
  static Color ripple(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.1)
        : Colors.black.withValues(alpha: 0.05);
  }

  // ============================================================================
  // SPECIAL COLORS
  // ============================================================================

  /// Shimmer base color (for loading states)
  static Color shimmerBase(BuildContext context) {
    return isDark(context) ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
  }

  /// Shimmer highlight color
  static Color shimmerHighlight(BuildContext context) {
    return isDark(context) ? const Color(0xFF334155) : const Color(0xFFF1F5F9);
  }

  /// Transparent
  static const Color transparent = Colors.transparent;

  /// White (always)
  static const Color white = Color(0xFFFFFFFF);

  /// Black (always)
  static const Color black = Color(0xFF000000);

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Check if current theme is dark
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get contrast text color for a background color
  static Color getContrastText(Color backgroundColor) {
    // Calculate luminance
    final luminance = backgroundColor.computeLuminance();
    // Return white for dark backgrounds, black for light backgrounds
    return luminance > 0.5 ? textPrimaryLight : textPrimaryDark;
  }

  /// Create a color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// Lighten a color
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Darken a color
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}
