import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/view/invoice_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingInvoiceItemCard extends StatelessWidget {
  final IconData icon;
  final String invoiceNumber;
  final String description;
  final String amount;
  final String billingId;
  final bool isSelected;
  final ValueChanged<bool>? onSelectionChanged;

  const BillingInvoiceItemCard({
    super.key,
    required this.icon,
    required this.invoiceNumber,
    required this.description,
    required this.amount,
    required this.billingId,
    this.isSelected = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvoiceDetailPage(billingId: billingId),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(16.r),
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
          children: [
            // Checkbox for selection
            if (onSelectionChanged != null)
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: GestureDetector(
                  onTap: () => onSelectionChanged?.call(!isSelected),
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.surface(context),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border(context),
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                        : null,
                  ),
                ),
              ),

            // Icon
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
                icon,
                size: 22.sp,
                color: AppColors.textTertiary(context),
              ),
            ),
            SizedBox(width: 16.w),

            // Invoice Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoiceNumber,
                    style: AppTextStyles.labelLarge(
                      color: AppColors.textPrimary(context),
                      fontWeight: AppTextStyles.semiBold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: AppTextStyles.labelSmall(
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              amount,
              style: AppTextStyles.titleMedium(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
