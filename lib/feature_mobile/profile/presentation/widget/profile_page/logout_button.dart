import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/widgets/dialog/confirmLogoutDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Logout button widget
/// Styled button for logging out of the app
class LogoutButton extends StatelessWidget {
  final VoidCallback? onConfirmLogout;

  const LogoutButton({super.key, this.onConfirmLogout});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.error.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ConfirmLogoutDialog(
              onConfirm: () {
                NavigationService.goBack();
                onConfirmLogout?.call();
              },
              onCancel: () => NavigationService.goBack(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: AppColors.error, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Log Out',
                style: AppTextStyles.bodyLarge(
                  color: AppColors.error,
                  fontWeight: AppTextStyles.semiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
