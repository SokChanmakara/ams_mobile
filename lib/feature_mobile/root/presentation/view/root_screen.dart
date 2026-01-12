import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/home_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellLayout extends StatelessWidget {
  final Widget child;

  const ShellLayout({super.key, required this.child});

  // Map navigation indices to route paths
  static const List<String> _navigationRoutes = [
    '/home',
    '/payments',
    '/services',
    '/profile',
  ];

  void _onItemTapped(int index, BuildContext context) {
    if (index >= 0 && index < _navigationRoutes.length) {
      context.go(_navigationRoutes[index]);
    }
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;

    for (int i = 0; i < _navigationRoutes.length; i++) {
      if (location.startsWith(_navigationRoutes[i])) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: child,
      bottomNavigationBar: HomeBottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
