import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCompleteButton extends StatelessWidget {
  final bool hasReceipt;
  final VoidCallback onComplete;

  const PaymentCompleteButton({
    super.key,
    required this.hasReceipt,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        border: Border(
          top: BorderSide(
            color: AppColors.border(context).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: hasReceipt
                  ? AppColors.primary
                  : AppColors.textSecondary(context),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Complete Payment',
                  style: AppTextStyles.bodyLarge(
                    color: Colors.white,
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.check_circle_outline, size: 22.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
