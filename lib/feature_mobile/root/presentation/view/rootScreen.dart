import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellLayout extends StatelessWidget {
  final Widget child;

  const ShellLayout({super.key, required this.child});

  // Map navigation indices to route paths
  static const List<String> _navigationRoutes = [
    '/home',
    '/community',
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1E2936) : Colors.white;
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNavBar(
        isDark,
        surfaceColor,
        selectedIndex,
        context,
      ),
    );
  }

  Widget _buildBottomNavBar(
    bool isDark,
    Color surfaceColor,
    int selectedIndex,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.grey[200]!,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                isDark,
                Icons.home,
                'Home',
                0,
                selectedIndex == 0,
                context,
              ),
              _buildNavItem(
                isDark,
                Icons.groups_outlined,
                'Community',
                1,
                selectedIndex == 1,
                context,
              ),
              _buildNavItem(
                isDark,
                Icons.room_service_outlined,
                'Services',
                2,
                selectedIndex == 2,
                context,
              ),
              _buildNavItem(
                isDark,
                Icons.person_outline,
                'Profile',
                3,
                selectedIndex == 3,
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    bool isDark,
    IconData icon,
    String label,
    int index,
    bool isSelected,
    BuildContext context,
  ) {
    final color = isSelected
        ? const Color(0xFF137FEC)
        : (isDark ? Colors.grey[600] : Colors.grey[400]);

    return InkWell(
      onTap: () => _onItemTapped(index, context),
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
