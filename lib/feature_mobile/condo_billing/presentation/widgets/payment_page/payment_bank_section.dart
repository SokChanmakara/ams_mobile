import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentBankSection extends StatelessWidget {
  final String invoiceNumber;
  final VoidCallback onOpenBankApp;

  const PaymentBankSection({
    super.key,
    required this.invoiceNumber,
    required this.onOpenBankApp,
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay via Bank Transfer',
                      style: AppTextStyles.titleMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    Text(
                      'Manual bank transfer option',
                      style: AppTextStyles.caption(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Bank Details
          _buildBankDetailRow(context, 'Account Name', 'Condo Management Ltd'),
          SizedBox(height: 12.h),
          _buildBankDetailRow(context, 'Account Number', '1234-5678-9012'),
          SizedBox(height: 12.h),
          _buildBankDetailRow(context, 'Bank', 'Example Bank'),
          SizedBox(height: 12.h),
          _buildBankDetailRow(context, 'Reference', invoiceNumber),
          SizedBox(height: 20.h),

          // Open Bank Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onOpenBankApp,
              icon: Icon(Icons.open_in_new, size: 20.sp),
              label: const Text('Open Banking App'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium(
            color: AppColors.textSecondary(context),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium(
            color: AppColors.textPrimary(context),
            fontWeight: AppTextStyles.semiBold,
          ),
        ),
      ],
    );
  }
}
