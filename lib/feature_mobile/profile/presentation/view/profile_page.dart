import 'package:ams_mobile/feature_mobile/profile/presentation/widget/logout_button.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/profile_header.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/profile_option_item.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/profile_section.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/theme_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24.h),

            // Profile Header
            const ProfileHeader(
              name: 'Sarah Johnson',
              unitInfo: 'Unit 402 • The Azure Tower',
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAfrP5_FGFDQdCv_MtkmyKRcAYlgaYUUGCb5JGRiK70eVeHzoIuSypr-O89zo-wcuw8eLVwss_ggSAQAMdqjTqCAqZq_FZbzPYLPZcnAGUpf4FDzK0CjV7APWFWhapQm_3Z68-b3VTMDXHgn3sycgwhliNi0esGmsrKWo9k3ShO_hIYmIO6xtrhx877uAMRA2GlXBeEHFnm0qL1zhAyVCeGINZLpSytOEst78KspMj2Z8EiNkAeE9yQaSb6BsaQ084M4CFar5qR40f8',
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
                        subtitle: 'Update your details',
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
                    onTap: () {
                      // TODO: Implement logout logic
                    },
                  ),

                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
