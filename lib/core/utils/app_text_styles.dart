import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized text style management class for the application
/// Uses Sofia Sans font family with responsive sizing via ScreenUtil
class AppTextStyles {
  AppTextStyles._();

  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // Base text style with Sofia Sans
  static TextStyle _baseStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.sofiaSans(
      fontSize: fontSize?.sp,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Display Styles (Largest)
  static TextStyle displayLarge({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 57,
        fontWeight: fontWeight ?? bold,
        color: color,
        height: 1.12,
      );

  static TextStyle displayMedium({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 45,
        fontWeight: fontWeight ?? bold,
        color: color,
        height: 1.16,
      );

  static TextStyle displaySmall({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 36,
        fontWeight: fontWeight ?? semiBold,
        color: color,
        height: 1.22,
      );

  // Headline Styles
  static TextStyle headlineLarge({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 32,
        fontWeight: fontWeight ?? semiBold,
        color: color,
        height: 1.25,
      );

  static TextStyle headlineMedium({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 28,
        fontWeight: fontWeight ?? semiBold,
        color: color,
        height: 1.29,
      );

  static TextStyle headlineSmall({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 24,
        fontWeight: fontWeight ?? medium,
        color: color,
        height: 1.33,
      );

  // Title Styles
  static TextStyle titleLarge({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 22,
        fontWeight: fontWeight ?? medium,
        color: color,
        height: 1.27,
      );

  static TextStyle titleMedium({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? medium,
        color: color,
        height: 1.5,
        letterSpacing: 0.15,
      );

  static TextStyle titleSmall({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? medium,
        color: color,
        height: 1.43,
        letterSpacing: 0.1,
      );

  // Body Styles
  static TextStyle bodyLarge({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? regular,
        color: color,
        height: 1.5,
        letterSpacing: 0.5,
      );

  static TextStyle bodyMedium({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? regular,
        color: color,
        height: 1.43,
        letterSpacing: 0.25,
      );

  static TextStyle bodySmall({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 12,
        fontWeight: fontWeight ?? regular,
        color: color,
        height: 1.33,
        letterSpacing: 0.4,
      );

  // Label Styles
  static TextStyle labelLarge({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? medium,
        color: color,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle labelMedium({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 12,
        fontWeight: fontWeight ?? medium,
        color: color,
        height: 1.33,
        letterSpacing: 0.5,
      );

  static TextStyle labelSmall({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 11,
        fontWeight: fontWeight ?? medium,
        color: color,
        height: 1.45,
        letterSpacing: 0.5,
      );

  // Custom Sizes for specific use cases
  static TextStyle h1({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(fontSize: 32, fontWeight: fontWeight ?? bold, color: color);

  static TextStyle h2({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(fontSize: 28, fontWeight: fontWeight ?? bold, color: color);

  static TextStyle h3({Color? color, FontWeight? fontWeight}) => _baseStyle(
    fontSize: 24,
    fontWeight: fontWeight ?? semiBold,
    color: color,
  );

  static TextStyle h4({Color? color, FontWeight? fontWeight}) => _baseStyle(
    fontSize: 20,
    fontWeight: fontWeight ?? semiBold,
    color: color,
  );

  static TextStyle h5({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(fontSize: 18, fontWeight: fontWeight ?? medium, color: color);

  static TextStyle h6({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(fontSize: 16, fontWeight: fontWeight ?? medium, color: color);

  static TextStyle subtitle1({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? regular,
        color: color,
        height: 1.5,
      );

  static TextStyle subtitle2({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? medium,
        color: color,
        height: 1.43,
      );

  static TextStyle caption({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 12,
        fontWeight: fontWeight ?? regular,
        color: color,
        height: 1.33,
      );

  static TextStyle overline({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 10,
        fontWeight: fontWeight ?? regular,
        color: color,
        height: 1.6,
        letterSpacing: 1.5,
      );

  // Button Styles
  static TextStyle button({Color? color, FontWeight? fontWeight}) => _baseStyle(
    fontSize: 14,
    fontWeight: fontWeight ?? medium,
    color: color,
    letterSpacing: 1.25,
  );

  static TextStyle buttonLarge({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? medium,
        color: color,
        letterSpacing: 1.25,
      );

  static TextStyle buttonSmall({Color? color, FontWeight? fontWeight}) =>
      _baseStyle(
        fontSize: 12,
        fontWeight: fontWeight ?? medium,
        color: color,
        letterSpacing: 1.25,
      );

  // Custom method for dynamic font sizes
  static TextStyle customSize({
    required double fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
  }) => _baseStyle(
    fontSize: fontSize,
    fontWeight: fontWeight ?? regular,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );

  /// Get the base Sofia Sans TextTheme for the entire app
  static TextTheme getTextTheme({Color? color}) {
    return TextTheme(
      displayLarge: displayLarge(color: color),
      displayMedium: displayMedium(color: color),
      displaySmall: displaySmall(color: color),
      headlineLarge: headlineLarge(color: color),
      headlineMedium: headlineMedium(color: color),
      headlineSmall: headlineSmall(color: color),
      titleLarge: titleLarge(color: color),
      titleMedium: titleMedium(color: color),
      titleSmall: titleSmall(color: color),
      bodyLarge: bodyLarge(color: color),
      bodyMedium: bodyMedium(color: color),
      bodySmall: bodySmall(color: color),
      labelLarge: labelLarge(color: color),
      labelMedium: labelMedium(color: color),
      labelSmall: labelSmall(color: color),
    );
  }
}
