import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Global navigation service for navigating without BuildContext
///
/// Usage:
/// - NavigationService.navigateTo('/home')
/// - NavigationService.navigateToNamed('home', params: {'id': '123'})
/// - NavigationService.goBack()
/// - NavigationService.showSnackBar('Message')
class NavigationService {
  // Global key for accessing navigator state
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Get the current BuildContext
  static BuildContext? get context => navigatorKey.currentContext;

  // Get the current GoRouter instance
  static GoRouter? get router {
    final ctx = context;
    if (ctx != null) {
      return GoRouter.of(ctx);
    }
    return null;
  }

  /// Navigate to a route by path
  /// Example: NavigationService.navigateTo('/home')
  static void navigateTo(String path, {Object? extra}) {
    final ctx = context;
    if (ctx != null) {
      ctx.go(path, extra: extra);
    }
  }

  /// Push a new route on top of the current route
  /// Example: NavigationService.push('/details')
  static void push(String path, {Object? extra}) {
    final ctx = context;
    if (ctx != null) {
      ctx.push(path, extra: extra);
    }
  }

  /// Navigate to a named route
  /// Example: NavigationService.navigateToNamed('home', params: {'id': '123'})
  static void navigateToNamed(
    String name, {
    Map<String, String> params = const {},
    Map<String, dynamic> queryParams = const {},
    Object? extra,
  }) {
    final ctx = context;
    if (ctx != null) {
      ctx.goNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );
    }
  }

  /// Push a named route on top of the current route
  /// Example: NavigationService.pushNamed('details', params: {'id': '123'})
  static void pushNamed(
    String name, {
    Map<String, String> params = const {},
    Map<String, dynamic> queryParams = const {},
    Object? extra,
  }) {
    final ctx = context;
    if (ctx != null) {
      ctx.pushNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );
    }
  }

  /// Go back to the previous route
  /// Example: NavigationService.goBack()
  static void goBack({String? fallback}) {
    final ctx = context;
    if (ctx != null && ctx.canPop()) {
      ctx.pop();
    } else if (fallback != null && ctx != null) {
      ctx.go(fallback);
    }
  }

  /// Pop with a result
  /// Example: NavigationService.popWithResult({'success': true})
  static void popWithResult<T>(T result) {
    final ctx = context;
    if (ctx != null && ctx.canPop()) {
      ctx.pop(result);
    }
  }

  /// Replace the current route
  /// Example: NavigationService.replace('/home')
  static void replace(String path, {Object? extra}) {
    final ctx = context;
    if (ctx != null) {
      ctx.pushReplacement(path, extra: extra);
    }
  }

  /// Replace with named route
  /// Example: NavigationService.replaceNamed('home')
  static void replaceNamed(
    String name, {
    Map<String, String> params = const {},
    Map<String, dynamic> queryParams = const {},
    Object? extra,
  }) {
    final ctx = context;
    if (ctx != null) {
      ctx.pushReplacementNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );
    }
  }

  /// Check if we can pop
  static bool canPop() {
    final ctx = context;
    return ctx?.canPop() ?? false;
  }

  /// Show a SnackBar
  /// Example: NavigationService.showSnackBar('Success!')
  static void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    final ctx = context;
    if (ctx != null) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          action: action,
          backgroundColor: backgroundColor,
        ),
      );
    }
  }

  /// Show a dialog
  /// Example: NavigationService.showDialogBox(builder: (context) => AlertDialog(...))
  static Future<T?> showDialogBox<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) async {
    final ctx = context;
    if (ctx != null) {
      return showDialog<T>(
        context: ctx,
        barrierDismissible: barrierDismissible,
        builder: builder,
      );
    }
    return null;
  }

  /// Show a bottom sheet
  /// Example: NavigationService.showSheet(builder: (context) => Container(...))
  static Future<T?> showSheet<T>({
    required Widget Function(BuildContext) builder,
    bool isDismissible = true,
    bool enableDrag = true,
  }) async {
    final ctx = context;
    if (ctx != null) {
      return showModalBottomSheet<T>(
        context: ctx,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        builder: builder,
      );
    }
    return null;
  }
}
