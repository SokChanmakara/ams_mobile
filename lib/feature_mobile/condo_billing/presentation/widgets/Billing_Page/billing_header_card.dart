import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingHeaderCard extends StatelessWidget {
  const BillingHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface(context).withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(color: AppColors.border(context), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => NavigationService.goBack(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.isDark(context)
                    ? AppColors.surfaceDark
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18.sp,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),

          // Title
          Expanded(
            child: Text(
              'My Unit Bill Details',
              textAlign: TextAlign.center,
              style: AppTextStyles.titleMedium(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.semiBold,
              ),
            ),
          ),

          SizedBox(width: 40.w), // Balance the back button
        ],
      ),
    );
  }
}
