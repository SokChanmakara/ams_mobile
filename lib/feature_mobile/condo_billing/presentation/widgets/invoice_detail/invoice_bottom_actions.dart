import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/data/model/payment_status_step_model.dart';

/// Bottom Action Buttons widget
class InvoiceBottomActions extends StatelessWidget {
  final String balanceDue;
  final List<PaymentStatusStep> statusSteps;
  final VoidCallback onPayPressed;

  const InvoiceBottomActions({
    super.key,
    required this.balanceDue,
    required this.statusSteps,
    required this.onPayPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Check if invoice is already paid/cleared
    final bool isPaid = statusSteps.any(
      (step) =>
          step.title == 'Invoice Cleared' &&
          step.status == StepStatus.completed,
    );

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context).withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: AppColors.border(context).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Primary Action Button
            if (!isPaid)
              ElevatedButton(
                onPressed: onPayPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 8,
                  shadowColor: AppColors.primary.withValues(alpha: 0.25),
                  minimumSize: Size(double.infinity, 56.h),
                ),
                child: Text(
                  'Pay $balanceDue Now',
                  style: AppTextStyles.bodyLarge(
                    color: Colors.white,
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
