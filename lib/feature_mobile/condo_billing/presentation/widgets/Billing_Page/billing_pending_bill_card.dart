import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_invoice_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingPendingBillCard extends StatelessWidget {
  const BillingPendingBillCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PENDING BILLINGS',
                style: AppTextStyles.overline(
                  color: AppColors.textTertiary(context),
                  fontWeight: AppTextStyles.bold,
                ),
              ),

              // Invoice Count Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '3 Invoices',
                  style: AppTextStyles.labelSmall(
                    color: AppColors.primary,
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Total Outstanding Card
        Container(
          padding: EdgeInsets.all(24.w),
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: AppColors.border(context).withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 15,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Total Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Outstanding',
                    style: AppTextStyles.caption(
                      color: AppColors.textSecondary(context),
                      fontWeight: AppTextStyles.medium,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\$1,060.00',
                    style: AppTextStyles.displaySmall(
                      color: AppColors.textPrimary(context),
                      fontWeight: AppTextStyles.bold,
                    ),
                  ),
                ],
              ),

              // Icon
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 28.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),

        // Invoice List
        Column(
          children: [
            BillingInvoiceItemCard(
              icon: Icons.receipt_long_outlined,
              invoiceNumber: 'INV-2601-000013',
              description: 'Management Fee • Oct 2023',
              amount: '\$450.00',
            ),
            SizedBox(height: 12.h),
            BillingInvoiceItemCard(
              icon: Icons.water_drop_outlined,
              invoiceNumber: 'INV-2601-000014',
              description: 'Utilities • Oct 2023',
              amount: '\$320.00',
            ),
            SizedBox(height: 12.h),
            BillingInvoiceItemCard(
              icon: Icons.security_outlined,
              invoiceNumber: 'INV-2601-000015',
              description: 'Sinking Fund • Oct 2023',
              amount: '\$290.00',
            ),
          ],
        ),
      ],
    );
  }
}
