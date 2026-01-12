import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

/// Status Chip widget
class InvoiceStatusChip extends StatelessWidget {
  final String status;

  const InvoiceStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              status,
              style: AppTextStyles.bodyMedium(
                color: AppColors.primary,
                fontWeight: AppTextStyles.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
