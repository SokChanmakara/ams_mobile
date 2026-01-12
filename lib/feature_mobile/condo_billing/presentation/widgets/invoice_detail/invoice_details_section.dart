import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

/// Invoice Details Section widget
class InvoiceDetailsSection extends StatelessWidget {
  final String description;
  final String billingPeriod;
  final String condominium;

  const InvoiceDetailsSection({
    super.key,
    required this.description,
    required this.billingPeriod,
    required this.condominium,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Text(
            'Invoice Details',
            style: AppTextStyles.titleLarge(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),
          SizedBox(height: 8.h),

          // Details Card
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.border(context).withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                // Description
                _DetailItem(
                  icon: Icons.build_outlined,
                  label: 'DESCRIPTION',
                  value: description,
                ),

                // Divider
                Divider(
                  height: 1,
                  color: AppColors.divider(context).withValues(alpha: 0.2),
                ),

                // Billing Period
                _DetailItem(
                  icon: Icons.calendar_today,
                  label: 'BILLING PERIOD',
                  value: billingPeriod,
                ),

                // Divider
                Divider(
                  height: 1,
                  color: AppColors.divider(context).withValues(alpha: 0.2),
                ),

                // Condominium
                _DetailItem(
                  icon: Icons.apartment_outlined,
                  label: 'CONDOMINIUM',
                  value: condominium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 24.sp, color: AppColors.primary),
          ),
          SizedBox(width: 16.w),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.overline(
                    color: AppColors.textSecondary(context),
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: AppTextStyles.titleMedium(
                    color: AppColors.textPrimary(context),
                    fontWeight: AppTextStyles.medium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
