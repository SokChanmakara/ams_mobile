import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/view/login.dart';
import 'package:ams_mobile/feature_mobile/community/community_page.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/home_content.dart';
import 'package:ams_mobile/feature_mobile/root/presentation/view/rootScreen.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/view/profile_page.dart';
import 'package:ams_mobile/feature_mobile/service/service_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ShellLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const HomeContent()),
          ),
          GoRoute(
            path: '/community',
            name: 'community',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const CommunityPage()),
          ),
          GoRoute(
            path: '/services',
            name: 'services',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const ServicePage()),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const ProfilePage()),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri.path}')),
    ),
  );
}
