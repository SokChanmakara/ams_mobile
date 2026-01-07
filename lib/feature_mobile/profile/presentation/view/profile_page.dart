import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
// import 'package:ams_mobile/core/widgets/test_refresh_token_button.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_event.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_provider.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_state.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/logout_button.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/profile_header.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/profile_option_item.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/profile_section.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/theme_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    // Fetch profile on initial load
    if (profileState is ProfileInitial) {
      Future.microtask(
        () => ref.read(profileNotifierProvider.notifier).fetchProfile(),
      );
    }

    // Listen to auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is LogoutSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Logged out successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        NavigationService.navigateTo('/login');
      } else if (next is LogoutFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    // Listen to profile state for authentication errors
    ref.listen<ProfileState>(profileNotifierProvider, (previous, next) {
      if (next is ProfileUnauthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: AppColors.error,
          ),
        );
        // Navigate to login after a short delay
        Future.delayed(const Duration(milliseconds: 1500), () {
          NavigationService.navigateTo('/login');
        });
      }
    });

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await ref.read(profileNotifierProvider.notifier).fetchProfile();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: _buildContent(context, ref, profileState),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ProfileState state,
  ) {
    return switch (state) {
      ProfileInitial() || ProfileLoading() => _buildLoadingState(),
      ProfileLoaded() => _buildLoadedState(context, ref, state),
      ProfileFailure() => _buildErrorState(context, ref, state),
      ProfileUnauthenticated() => _buildUnauthenticatedState(
        context,
        ref,
        state,
      ),
    };
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 600.h,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    WidgetRef ref,
    ProfileFailure state,
  ) {
    return SizedBox(
      height: 600.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.error),
            SizedBox(height: 16.h),
            Text(
              'Failed to load profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(profileNotifierProvider.notifier).fetchProfile();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnauthenticatedState(
    BuildContext context,
    WidgetRef ref,
    ProfileUnauthenticated state,
  ) {
    return SizedBox(
      height: 600.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 64, color: AppColors.error),
            SizedBox(height: 16.h),
            Text(
              'Session Expired',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(context),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () {
                NavigationService.navigateTo('/login');
              },
              icon: const Icon(Icons.login),
              label: const Text('Go to Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(
    BuildContext context,
    WidgetRef ref,
    ProfileLoaded state,
  ) {
    final profile = state.userProfile;

    return Column(
      children: [
        SizedBox(height: 24.h),

        // Profile Header with real data
        ProfileHeader(
          name: profile.fullName,
          unitInfo: profile.unitInfo,
          imageUrl: profile.imageUrl,
        ),

        SizedBox(height: 32.h),

        // Profile Options
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Section
              ProfileSection(
                title: 'Account',
                children: [
                  ProfileOptionItem(
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    subtitle: profile.email,
                    onTap: () {
                      // TODO: Navigate to personal info page
                    },
                  ),
                  ProfileOptionItem(
                    icon: Icons.home_outlined,
                    title: 'Unit Details',
                    subtitle: 'View unit information',
                    onTap: () {
                      // TODO: Navigate to unit details page
                    },
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Preferences Section
              ProfileSection(
                title: 'Preferences',
                children: [
                  const ThemeOptionItem(),
                  ProfileOptionItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Manage your alerts',
                    onTap: () {
                      // TODO: Navigate to notifications settings
                    },
                  ),
                  ProfileOptionItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Manage your alerts',
                    onTap: () {
                      // TODO: Navigate to notifications settings
                    },
                  ),
                  ProfileOptionItem(
                    icon: Icons.lock_outline,
                    title: 'Privacy & Security',
                    subtitle: 'Control your privacy',
                    onTap: () {
                      // TODO: Navigate to privacy settings
                    },
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Support Section
              ProfileSection(
                title: 'Support',
                children: [
                  ProfileOptionItem(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    subtitle: 'Get support and FAQs',
                    onTap: () {
                      // TODO: Navigate to help center
                    },
                  ),
                  ProfileOptionItem(
                    icon: Icons.info_outline,
                    title: 'About',
                    subtitle: 'App version and info',
                    onTap: () {
                      // TODO: Navigate to about page
                    },
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Logout Button
              LogoutButton(
                onConfirmLogout: () {
                  ref
                      .read(authNotifierProvider.notifier)
                      .handleEvent(const LogoutEvent());
                },
              ),

              // TestRefreshTokenButton(),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ],
    );
  }
}
