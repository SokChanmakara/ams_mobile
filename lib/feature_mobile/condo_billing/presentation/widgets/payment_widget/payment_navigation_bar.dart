import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

/// Navigation Bar for Payment Page
class PaymentNavigationBar extends StatelessWidget {
  const PaymentNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        border: Border(
          bottom: BorderSide(
            color: AppColors.border(context).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => NavigationService.goBack(fallback: '/home'),
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
              'Transaction Receipt',
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.bold,
              ),
            ),
          ),

          // Share Button (placeholder)
        ],
      ),
    );
  }
}
