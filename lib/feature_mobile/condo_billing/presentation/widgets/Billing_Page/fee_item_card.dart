import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeeItemCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;

  const FeeItemCard({
    super.key,
    required this.icon,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border(context)),
            ),
            child: Icon(
              icon,
              size: 16.sp,
              color: AppColors.textTertiary(context),
            ),
          ),
          SizedBox(width: 12.w),

          // Label
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondary(context),
                fontWeight: AppTextStyles.medium,
              ),
            ),
          ),

          // Amount
          Text(
            amount,
            style: AppTextStyles.bodyMedium(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
