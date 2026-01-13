import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/data/model/payment_status_step_model.dart';

/// Payment Status Timeline widget
class PaymentStatusTimeline extends StatelessWidget {
  final List<PaymentStatusStep> statusSteps;

  const PaymentStatusTimeline({super.key, required this.statusSteps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Status',
            style: AppTextStyles.titleLarge(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),
          SizedBox(height: 16.h),

          // Timeline
          _buildTimeline(context),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Column(
        children: List.generate(
          statusSteps.length,
          (index) => _TimelineStep(
            step: statusSteps[index],
            isLast: index == statusSteps.length - 1,
          ),
        ),
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  final PaymentStatusStep step;
  final bool isLast;

  const _TimelineStep({required this.step, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    Color? ringColor;
    double opacity = 1.0;

    switch (step.status) {
      case StepStatus.completed:
        iconColor = AppColors.success;
        ringColor = null;
        break;
      case StepStatus.current:
        iconColor = AppColors.primary;
        ringColor = AppColors.primary.withValues(alpha: 0.2);
        break;
      case StepStatus.inactive:
        iconColor = AppColors.textTertiary(context);
        ringColor = null;
        opacity = 0.5;
        break;
    }

    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            SizedBox(
              width: 26.w,
              child: Column(
                children: [
                  // Icon Circle
                  Container(
                    width: 26.w,
                    height: 26.w,
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                      border: ringColor != null
                          ? Border.all(color: ringColor, width: 4)
                          : null,
                    ),
                    child: Icon(step.icon, size: 14.sp, color: Colors.white),
                  ),

                  // Connecting Line
                  if (!isLast)
                    Container(
                      width: 2.w,
                      height: 40.h,
                      margin: EdgeInsets.only(top: 4.h),
                      color: AppColors.isDark(context)
                          ? AppColors.dividerDark
                          : Colors.grey[300],
                    ),
                ],
              ),
            ),
            SizedBox(width: 16.w),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    if (step.subtitle != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        step.subtitle!,
                        style: AppTextStyles.caption(
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ],
                    if (step.hasAction) ...[
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Opening ${step.actionLabel}'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 14.sp,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              step.actionLabel ?? '',
                              style: AppTextStyles.caption(
                                color: AppColors.primary,
                                fontWeight: AppTextStyles.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
