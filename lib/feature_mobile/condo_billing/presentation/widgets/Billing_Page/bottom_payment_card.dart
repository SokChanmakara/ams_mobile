import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomPaymentCard extends StatelessWidget {
  const BottomPaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context).withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(color: AppColors.border(context), width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () {
            // Payment action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 4,
            shadowColor: AppColors.primary.withValues(alpha: 0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pay \$450.00 Now',
                style: AppTextStyles.buttonLarge(
                  color: Colors.white,
                  fontWeight: AppTextStyles.semiBold,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.arrow_forward, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
