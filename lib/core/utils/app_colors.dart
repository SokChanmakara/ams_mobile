import 'package:flutter/material.dart';

/// Premium app color system with light and dark theme support
/// Usage: AppColors.primary, AppColors.background(context)
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ============================================================================
  // PRIMARY COLORS - Refined Blue Palette
  // ============================================================================

  /// Main brand color - Premium Blue
  static const Color primary = Color(0xFF1E88E5);

  /// Darker shade of primary (for pressed states)
  static const Color primaryDark = Color(0xFF1565C0);

  /// Lighter shade of primary (for hover states)
  static const Color primaryLight = Color(0xFF42A5F5);

  /// Very light primary (for backgrounds/surfaces)
  static const Color primarySurface = Color(0xFFE3F2FD);

  /// Ultra light primary (for subtle highlights)
  static const Color primarySurfaceLight = Color(0xFFF5FAFF);

  // ============================================================================
  // ACCENT COLORS
  // ============================================================================

  /// Secondary accent color
  static const Color accent = Color(0xFF5E35B1);
  static const Color accentLight = Color(0xFF7E57C2);
  static const Color accentSurface = Color(0xFFEDE7F6);

  // ============================================================================
  // NEUTRAL COLORS - Enhanced Gray Scale
  // ============================================================================

  /// Neutral colors for backgrounds and surfaces
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);

  // ============================================================================
  // BACKGROUND COLORS
  // ============================================================================

  /// Main background color (context-aware)
  static Color background(BuildContext context) {
    return isDark(context) ? backgroundDark : backgroundLight;
  }

  /// Light mode background - Soft white
  static const Color backgroundLight = Color(0xFFFAFAFA);

  /// Dark mode background - Deep blue-black
  static const Color backgroundDark = Color(0xFF0A0E27);

  /// Secondary background (context-aware)
  static Color backgroundSecondary(BuildContext context) {
    return isDark(context) ? const Color(0xFF121631) : neutral50;
  }

  // ============================================================================
  // SURFACE COLORS (Cards, Containers)
  // ============================================================================

  /// Surface color (context-aware)
  static Color surface(BuildContext context) {
    return isDark(context) ? surfaceDark : surfaceLight;
  }

  /// Light mode surface - Pure white
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Dark mode surface - Elevated dark blue
  static const Color surfaceDark = Color(0xFF1A1F3A);

  /// Elevated surface (slightly lighter)
  static Color surfaceElevated(BuildContext context) {
    return isDark(context) ? const Color(0xFF232949) : const Color(0xFFFFFFFF);
  }

  /// Hover surface (context-aware)
  static Color surfaceHover(BuildContext context) {
    return isDark(context) ? const Color(0xFF2A3250) : neutral100;
  }

  // ============================================================================
  // TEXT COLORS
  // ============================================================================

  /// Primary text color (context-aware)
  static Color textPrimary(BuildContext context) {
    return isDark(context) ? textPrimaryDark : textPrimaryLight;
  }

  /// Light mode primary text - Rich black
  static const Color textPrimaryLight = Color(0xFF0D1117);

  /// Dark mode primary text - Pure white
  static const Color textPrimaryDark = Color(0xFFFAFAFA);

  /// Secondary text color (context-aware)
  static Color textSecondary(BuildContext context) {
    return isDark(context) ? textSecondaryDark : textSecondaryLight;
  }

  /// Light mode secondary text
  static const Color textSecondaryLight = Color(0xFF57606A);

  /// Dark mode secondary text
  static const Color textSecondaryDark = Color(0xFFADB5BD);

  /// Tertiary/hint text color (context-aware)
  static Color textTertiary(BuildContext context) {
    return isDark(context) ? textTertiaryDark : textTertiaryLight;
  }

  /// Light mode tertiary text
  static const Color textTertiaryLight = Color(0xFF8B949E);

  /// Dark mode tertiary text
  static const Color textTertiaryDark = Color(0xFF6E7681);

  /// Disabled text color (context-aware)
  static Color textDisabled(BuildContext context) {
    return isDark(context) ? const Color(0xFF484F58) : const Color(0xFFCED4DA);
  }

  // ============================================================================
  // BORDER COLORS
  // ============================================================================

  /// Border color (context-aware)
  static Color border(BuildContext context) {
    return isDark(context) ? borderDark : borderLight;
  }

  /// Light mode border - Subtle gray
  static const Color borderLight = Color(0xFFE1E4E8);

  /// Dark mode border
  static const Color borderDark = Color(0xFF30363D);

  /// Focused border color
  static const Color borderFocused = primary;

  /// Strong border (context-aware)
  static Color borderStrong(BuildContext context) {
    return isDark(context) ? const Color(0xFF3D4450) : neutral300;
  }

  // ============================================================================
  // SEMANTIC COLORS - Enhanced
  // ============================================================================

  /// Success color - Vibrant green
  static const Color success = Color(0xFF00C853);
  static const Color successLight = Color(0xFFB9F6CA);
  static const Color successDark = Color(0xFF00A843);
  static const Color successSurface = Color(0xFFE8F5E9);

  /// Error color - Modern red
  static const Color error = Color(0xFFFF3D00);
  static const Color errorLight = Color(0xFFFFCDD2);
  static const Color errorDark = Color(0xFFD32F2F);
  static const Color errorSurface = Color(0xFFFFEBEE);

  /// Warning color - Bright amber
  static const Color warning = Color(0xFFFFAB00);
  static const Color warningLight = Color(0xFFFFE082);
  static const Color warningDark = Color(0xFFFF8F00);
  static const Color warningSurface = Color(0xFFFFF8E1);

  /// Info color - Cool blue
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFBBDEFB);
  static const Color infoDark = Color(0xFF1976D2);
  static const Color infoSurface = Color(0xFFE3F2FD);

  // ============================================================================
  // GRADIENT PRESETS - Premium gradients
  // ============================================================================

  /// Primary gradient (light to dark)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
  );

  /// Enhanced primary gradient (3 stops)
  static const LinearGradient primaryGradientEnhanced = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF42A5F5), Color(0xFF1E88E5), Color(0xFF1565C0)],
    stops: [0.0, 0.5, 1.0],
  );

  /// Success gradient
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00E676), Color(0xFF00C853)],
  );

  /// Premium dark gradient
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1F3A), Color(0xFF0A0E27)],
  );

  /// Shimmer gradient
  static LinearGradient shimmerGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark(context)
          ? [
              const Color(0xFF1A1F3A),
              const Color(0xFF232949),
              const Color(0xFF1A1F3A),
            ]
          : [
              const Color(0xFFEEEEEE),
              const Color(0xFFF5F5F5),
              const Color(0xFFEEEEEE),
            ],
    );
  }

  // ============================================================================
  // ICON COLORS
  // ============================================================================

  /// Default icon color (context-aware)
  static Color icon(BuildContext context) {
    return isDark(context) ? iconDark : iconLight;
  }

  /// Light mode icon
  static const Color iconLight = Color(0xFF57606A);

  /// Dark mode icon
  static const Color iconDark = Color(0xFFADB5BD);

  /// Active/focused icon color
  static const Color iconActive = primary;

  /// Muted icon color (context-aware)
  static Color iconMuted(BuildContext context) {
    return isDark(context) ? const Color(0xFF6E7681) : neutral400;
  }

  // ============================================================================
  // DIVIDER COLORS
  // ============================================================================

  /// Divider color (context-aware)
  static Color divider(BuildContext context) {
    return isDark(context) ? dividerDark : dividerLight;
  }

  /// Light mode divider
  static const Color dividerLight = Color(0xFFE1E4E8);

  /// Dark mode divider
  static const Color dividerDark = Color(0xFF30363D);

  // ============================================================================
  // SHADOW COLORS - Premium shadows
  // ============================================================================

  /// Shadow color (context-aware)
  static Color shadow(BuildContext context) {
    return isDark(context)
        ? Colors.black.withValues(alpha: 0.4)
        : Colors.black.withValues(alpha: 0.08);
  }

  /// Light shadow - Subtle
  static Color shadowLight = Colors.black.withValues(alpha: 0.04);

  /// Medium shadow - Elevated
  static Color shadowMedium = Colors.black.withValues(alpha: 0.1);

  /// Strong shadow - Prominent
  static Color shadowStrong = Colors.black.withValues(alpha: 0.16);

  /// Colored shadow for primary elements
  static Color shadowPrimary = primary.withValues(alpha: 0.25);

  /// Colored shadow for success elements
  static Color shadowSuccess = success.withValues(alpha: 0.25);

  // ============================================================================
  // OVERLAY COLORS
  // ============================================================================

  /// Overlay for dialogs, bottom sheets (context-aware)
  static Color overlay(BuildContext context) {
    return isDark(context)
        ? Colors.black.withValues(alpha: 0.7)
        : Colors.black.withValues(alpha: 0.5);
  }

  /// Ripple/splash color (context-aware)
  static Color ripple(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.04);
  }

  /// Scrim overlay (for bottom sheets, modals)
  static Color scrim(BuildContext context) {
    return isDark(context)
        ? Colors.black.withValues(alpha: 0.8)
        : Colors.black.withValues(alpha: 0.6);
  }

  // ============================================================================
  // SPECIAL COLORS
  // ============================================================================

  /// Shimmer base color (for loading states)
  static Color shimmerBase(BuildContext context) {
    return isDark(context) ? const Color(0xFF1A1F3A) : neutral200;
  }

  /// Shimmer highlight color
  static Color shimmerHighlight(BuildContext context) {
    return isDark(context) ? const Color(0xFF232949) : neutral100;
  }

  /// Glass morphism background
  static Color glass(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.white.withValues(alpha: 0.7);
  }

  /// Frosted glass effect
  static Color glassFrosted(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.85);
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
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? textPrimaryLight : textPrimaryDark;
  }

  /// Create a color with opacity
  static Color withOpacity(Color color, double opacity) {
    assert(opacity >= 0 && opacity <= 1);
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

  /// Adjust color saturation
  static Color adjustSaturation(Color color, double amount) {
    assert(amount >= -1 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final saturation = (hsl.saturation + amount).clamp(0.0, 1.0);
    return hsl.withSaturation(saturation).toColor();
  }

  /// Get complementary color
  static Color complementary(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hue = (hsl.hue + 180) % 360;
    return hsl.withHue(hue).toColor();
  }

  /// Create gradient from single color
  static LinearGradient createGradient(
    Color color, {
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: [lighten(color, 0.1), color, darken(color, 0.1)],
      stops: const [0.0, 0.5, 1.0],
    );
  }
}
