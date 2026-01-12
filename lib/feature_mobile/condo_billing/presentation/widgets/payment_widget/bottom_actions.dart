import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

/// Bottom Actions for Payment Page
class BottomActions extends StatelessWidget {
  const BottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Download PDF Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Download PDF functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Downloading PDF receipt...'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 8,
              shadowColor: AppColors.primary.withValues(alpha: 0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download_for_offline, size: 24.sp),
                SizedBox(width: 12.w),
                Text(
                  'Download PDF Receipt',
                  style: AppTextStyles.bodyLarge(
                    color: Colors.white,
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
