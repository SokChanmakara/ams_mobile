import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/fee_item_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class FeeBreakdownCard extends StatelessWidget {
  const FeeBreakdownCard({super.key});

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
                'FEE BREAKDOWN',
                style: AppTextStyles.overline(
                  color: AppColors.textTertiary(context),
                  fontWeight: AppTextStyles.bold,
                ),
              ),

              // Full Statement Button
              TextButton(
                onPressed: () {
                  // Navigate to full statement
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  backgroundColor: AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Full Statement',
                      style: AppTextStyles.labelSmall(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.semiBold,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right,
                      size: 16.sp,
                      color: AppColors.textPrimary(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Fee Card
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.border(context)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Total Amount Header
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.divider(context).withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Total Label and Amount
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Monthly Due',
                          style: AppTextStyles.caption(
                            color: AppColors.textSecondary(context),
                            fontWeight: AppTextStyles.medium,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '\$450.00',
                              style: AppTextStyles.displaySmall(
                                color: AppColors.textPrimary(context),
                                fontWeight: AppTextStyles.bold,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '/ mo',
                              style: AppTextStyles.bodyMedium(
                                color: AppColors.textTertiary(context),
                                fontWeight: AppTextStyles.medium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Due Date Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.isDark(context)
                            ? AppColors.surfaceDark
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Text(
                        'DUE OCT 01',
                        style: AppTextStyles.overline(
                          color: AppColors.textSecondary(context),
                          fontWeight: AppTextStyles.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Fee Items List
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  children: [
                    FeeItemCard(
                      icon: Icons.apartment_outlined,
                      label: 'Common Element',
                      amount: '\$350.00',
                    ),
                    FeeItemCard(
                      icon: Icons.savings_outlined,
                      label: 'Reserve Fund',
                      amount: '\$80.00',
                    ),
                    FeeItemCard(
                      icon: Icons.garage_outlined,
                      label: 'Parking Maint.',
                      amount: '\$20.00',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension on int {
  double get w => toDouble();
}
