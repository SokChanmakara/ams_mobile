import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingUnitItemCard extends StatelessWidget {
  final String label;
  final String value;
  final String? suffix;
  const BillingUnitItemCard({
    super.key,
    required this.label,
    required this.value,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.overline(
            color: AppColors.textTertiary(context),
            fontWeight: AppTextStyles.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: AppTextStyles.bodyMedium(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.semiBold,
              ),
            ),
            if (suffix != null) ...[
              SizedBox(width: 2.w),
              Text(
                suffix!,
                style: AppTextStyles.overline(
                  color: AppColors.textTertiary(context),
                  fontWeight: AppTextStyles.medium,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
