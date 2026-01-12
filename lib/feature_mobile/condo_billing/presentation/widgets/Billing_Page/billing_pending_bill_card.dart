import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_provider.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_state.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_invoice_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingPendingBillCard extends ConsumerWidget {
  const BillingPendingBillCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billingState = ref.watch(billingNotifierProvider);

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
              if (billingState is BillingLoaded)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.isDark(context)
                        ? AppColors.surfaceDark
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '${billingState.data.summary.count} Invoice${billingState.data.summary.count != 1 ? 's' : ''}',
                    style: AppTextStyles.labelSmall(
                      color: AppColors.primary,
                      fontWeight: AppTextStyles.semiBold,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Loading State
        if (billingState is BillingLoading)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),

        // Error State
        if (billingState is BillingFailure)
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: AppColors.error,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    billingState.errorMessage,
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.textSecondary(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

        // Initial State
        if (billingState is BillingInitial)
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Center(
              child: Text(
                'Select a unit to view billings',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textSecondary(context),
                ),
              ),
            ),
          ),

        // Loaded State with Data
        if (billingState is BillingLoaded) ...[
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
                      billingState.data.formattedTotalOutstanding,
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
          if (billingState.data.billings.isNotEmpty)
            Column(
              children: billingState.data.billings.map((billing) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: BillingInvoiceItemCard(
                    icon: billing.billingTypeIcon,
                    invoiceNumber: billing.invoiceNumber,
                    description:
                        '${billing.description} • ${_formatDate(billing.billingDate)}',
                    amount: billing.formattedBalanceAmount,
                    billingId: billing.id,
                  ),
                );
              }).toList(),
            )
          else
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.surface(context),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  'No pending billings',
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}
