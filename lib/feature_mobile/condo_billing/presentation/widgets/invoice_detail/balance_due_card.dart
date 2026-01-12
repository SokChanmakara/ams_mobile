import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

/// Balance Due Card widget
class BalanceDueCard extends StatelessWidget {
  final String balanceDue;

  const BalanceDueCard({super.key, required this.balanceDue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.border(context).withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BALANCE DUE',
              style: AppTextStyles.overline(
                color: AppColors.textSecondary(context),
                fontWeight: AppTextStyles.medium,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              balanceDue,
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: AppTextStyles.extraBold,
                color: AppColors.primary,
                height: 1.1,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
