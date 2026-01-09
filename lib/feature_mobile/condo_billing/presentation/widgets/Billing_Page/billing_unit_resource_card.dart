import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingUnitResourceCard extends StatelessWidget {
  const BillingUnitResourceCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 16.h),
          child: Text(
            'UNIT RESOURCES',
            style: AppTextStyles.overline(
              color: AppColors.textTertiary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),
        ),

        // Resources Grid
        Row(
          children: [
            // Documents
            Expanded(
              child: ResourceButton(
                icon: Icons.description_outlined,
                label: 'Documents',
                onTap: () {
                  // Navigate to documents
                },
              ),
            ),
            SizedBox(width: 12.w),

            // Payment Logs
            Expanded(
              child: ResourceButton(
                icon: Icons.history_outlined,
                label: 'Payment Logs',
                onTap: () {
                  // Navigate to payment logs
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
