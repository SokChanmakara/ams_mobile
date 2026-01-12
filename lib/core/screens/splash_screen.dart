import 'package:ams_mobile/core/service/auth_state_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Splash screen shown during app initialization
/// Displays while checking authentication state
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Show splash for 2-3 seconds while checking auth
    final startTime = DateTime.now();

    // Check authentication
    final isAuthenticated = await _checkAuthentication();

    // Calculate elapsed time
    final elapsed = DateTime.now().difference(startTime);
    final remainingTime = const Duration(milliseconds: 1000) - elapsed;

    // Wait remaining time if auth check was too fast (minimum 2.5 seconds total)
    if (remainingTime.inMilliseconds > 0) {
      await Future.delayed(remainingTime);
    }

    // Navigate after splash is shown for at least 2.5 seconds
    if (mounted) {
      if (isAuthenticated) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    }
  }

  Future<bool> _checkAuthentication() async {
    try {
      return await AuthStateService.checkAuthState();
    } catch (e) {
      debugPrint('Error during auth check: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withValues(alpha: 0.7),
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Logo Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.apartment_rounded,
                    size: 80,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 32),

                // App Name
                const Text(
                  'AMS',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 8),

                // App Subtitle
                const Text(
                  'Apartment Management System',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                ),

                const Spacer(flex: 2),

                // Loading Indicator
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),

                const SizedBox(height: 16),

                // Loading Text
                const Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                // Version or Copyright
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
