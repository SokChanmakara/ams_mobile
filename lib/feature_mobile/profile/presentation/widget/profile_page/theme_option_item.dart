import 'package:ams_mobile/core/providers/theme_provider.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Theme option item with toggle switch
/// Allows users to switch between light and dark themes
class ThemeOptionItem extends ConsumerWidget {
  const ThemeOptionItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final isSystem = themeMode == ThemeMode.system;

    return Material(
      color: AppColors.surface(context),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border(context)),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow(context),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildIcon(context, isDark, isSystem),
            SizedBox(width: 16.w),
            Expanded(child: _buildContent(context, isDark, isSystem)),
            _buildSwitch(ref, isDark, isSystem),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, bool isDark, bool isSystem) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isSystem
            ? Icons.brightness_auto
            : (isDark ? Icons.dark_mode : Icons.light_mode),
        color: AppColors.primary,
        size: 20.sp,
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark, bool isSystem) {
    String title;
    String subtitle;

    if (isSystem) {
      title = 'Theme (System)';
      subtitle = 'Following system settings';
    } else if (isDark) {
      title = 'Theme (Dark)';
      subtitle = 'Dark mode enabled';
    } else {
      title = 'Theme (Light)';
      subtitle = 'Light mode enabled';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyLarge(fontWeight: AppTextStyles.semiBold),
        ),
        SizedBox(height: 2.h),
        Text(
          subtitle,
          style: AppTextStyles.bodySmall(
            color: AppColors.textSecondary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch(WidgetRef ref, bool isDark, bool isSystem) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode,
          color: !isDark && !isSystem
              ? AppColors.primary
              : AppColors.textTertiary(ref.context),
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        Switch(
          value: isDark,
          onChanged: (value) {
            if (value) {
              ref.read(themeModeProvider.notifier).setDarkMode();
            } else {
              ref.read(themeModeProvider.notifier).setLightMode();
            }
          },
        ),
        SizedBox(width: 8.w),
        Icon(
          Icons.dark_mode,
          color: isDark && !isSystem
              ? AppColors.primary
              : AppColors.textTertiary(ref.context),
          size: 20.sp,
        ),
      ],
    );
  }
}
