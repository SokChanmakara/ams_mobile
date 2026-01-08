import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AssetCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border(context)),
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
          // Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.isDark(context)
                  ? AppColors.surfaceDark
                  : Colors.grey[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: AppColors.textSecondary(context),
            ),
          ),
          SizedBox(height: 16.h),

          // Label
          Text(
            label,
            style: AppTextStyles.caption(
              color: AppColors.textSecondary(context),
              fontWeight: AppTextStyles.medium,
            ),
          ),
          SizedBox(height: 4.h),

          // Value
          Text(
            value,
            style: AppTextStyles.titleLarge(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),
        ],
      ),
    );
  }
}
