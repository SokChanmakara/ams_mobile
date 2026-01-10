import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentDetailCard extends StatelessWidget {
  final String description;
  final String amount;

  const PaymentDetailCard({
    super.key,
    required this.description,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.border(context).withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount to Pay',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textSecondary(context),
                  fontWeight: AppTextStyles.medium,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  'PENDING',
                  style: AppTextStyles.overline(
                    color: AppColors.warning,
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Amount Display
          Text(
            amount,
            style: AppTextStyles.displayMedium(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),

          // Divider
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 24.h),
            color: AppColors.divider(context).withValues(alpha: 0.3),
          ),

          // Description Section
          Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                size: 18.sp,
                color: AppColors.textSecondary(context),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  description,
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.textSecondary(context),
                    fontWeight: AppTextStyles.medium,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
