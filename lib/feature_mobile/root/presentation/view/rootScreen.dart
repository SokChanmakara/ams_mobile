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
      body: child,
      bottomNavigationBar: _buildBottomNavBar(selectedIndex, context),
    );
  }

  Widget _buildBottomNavBar(int selectedIndex, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        border: const Border(
          top: BorderSide(
            color: Color(0xFFF1F5F9), // slate-100
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.dashboard,
                label: 'Home',
                index: 0,
                isSelected: selectedIndex == 0,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.payments_outlined,
                label: 'Payments',
                index: 1,
                isSelected: selectedIndex == 1,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.room_service_sharp,
                label: 'Services',
                index: 2,
                isSelected: selectedIndex == 2,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                index: 3,
                isSelected: selectedIndex == 3,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required BuildContext context,
  }) {
    final color = isSelected
        ? Theme.of(context).primaryColor
        : const Color(0xFF94A3B8); // slate-400

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index, context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 26, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
