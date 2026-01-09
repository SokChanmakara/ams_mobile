import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickActionButtonCard extends StatelessWidget {
  final QuickAction action;
  const QuickActionButtonCard({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Action handler
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            width: 56.w,
            height: 56.w,
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
            child: Icon(
              action.icon,
              size: 24.sp,
              color: AppColors.textSecondary(context),
            ),
          ),
          SizedBox(height: 8.h),

          // Label
          Text(
            action.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall(
              color: AppColors.textSecondary(context),
              fontWeight: AppTextStyles.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class QuickAction {
  final IconData icon;
  final String label;

  QuickAction({required this.icon, required this.label});
}
