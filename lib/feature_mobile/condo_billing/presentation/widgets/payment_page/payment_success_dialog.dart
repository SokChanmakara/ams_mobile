import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Container(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                size: 48.sp,
                color: AppColors.success,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Payment Submitted!',
              style: AppTextStyles.headlineSmall(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Your payment is being processed. You will receive a confirmation once verified.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondary(context),
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Return to billing page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Done',
                  style: AppTextStyles.bodyLarge(
                    color: Colors.white,
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
