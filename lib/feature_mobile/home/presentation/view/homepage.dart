import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/home_content.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_provider.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CondoHomePage extends ConsumerStatefulWidget {
  const CondoHomePage({super.key});

  @override
  ConsumerState<CondoHomePage> createState() => _CondoHomePageState();
}

class _CondoHomePageState extends ConsumerState<CondoHomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch profile once on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(profileNotifierProvider);
      // Fetch profile if not already loaded or if loading
      if (state is! ProfileLoaded && state is! ProfileLoading) {
        ref.read(profileNotifierProvider.notifier).fetchProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileNotifierProvider);

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

    return switch (profileState) {
      ProfileInitial() ||
      ProfileLoading() => const Center(child: CircularProgressIndicator()),
      ProfileLoaded() => RefreshIndicator(
        onRefresh: () async {
          await ref.read(profileNotifierProvider.notifier).fetchProfile();
        },
        child: HomeContent(
          name: profileState.userProfile.fullName,
          unitInfo: profileState.userProfile.unitInfo,
          imageUrl: profileState.userProfile.imageUrl,
        ),
      ),
      ProfileFailure() => _buildErrorState(context, ref, profileState),
      ProfileUnauthenticated() => _buildUnauthenticatedState(
        context,
        ref,
        profileState,
      ),
    };
  }

  Widget _buildErrorState(
    BuildContext context,
    WidgetRef ref,
    ProfileFailure state,
  ) {
    return Center(
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
    );
  }

  Widget _buildUnauthenticatedState(
    BuildContext context,
    WidgetRef ref,
    ProfileUnauthenticated state,
  ) {
    return Center(
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
    );
  }
}
