import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

/// Settlement Details Card for Payment Page
class SettlementDetailsCard extends StatelessWidget {
  final String settlementNumber;
  final String description;
  final String location;
  final String paymentMethod;
  final String dateTime;
  final String referenceNumber;

  const SettlementDetailsCard({
    super.key,
    required this.settlementNumber,
    required this.description,
    required this.location,
    required this.paymentMethod,
    required this.dateTime,
    required this.referenceNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.border(context).withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: Text(
              'Settlement Details',
              style: AppTextStyles.titleLarge(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.bold,
              ),
            ),
          ),

          // Settlement Info with Image
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.divider(context).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Text Content
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        settlementNumber,
                        style: AppTextStyles.titleMedium(
                          color: AppColors.textPrimary(context),
                          fontWeight: AppTextStyles.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14.sp,
                            color: AppColors.textSecondary(context),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              location,
                              style: AppTextStyles.caption(
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Payment Details Grid
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Row 1: Payment Method & Date/Time
                Row(
                  children: [
                    // Payment Method
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        label: 'PAYMENT METHOD',
                        icon: Icons.credit_card,
                        value: paymentMethod,
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Date & Time
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        label: 'DATE & TIME',
                        icon: Icons.calendar_today,
                        value: dateTime,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Row 2: Reference Number (Full Width)
                _buildReferenceNumber(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.overline(
            color: AppColors.textSecondary(context),
            fontWeight: AppTextStyles.semiBold,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(icon, size: 18.sp, color: AppColors.primary),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                value,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textPrimary(context),
                  fontWeight: AppTextStyles.medium,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReferenceNumber(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REFERENCE NUMBER',
          style: AppTextStyles.overline(
            color: AppColors.textSecondary(context),
            fontWeight: AppTextStyles.semiBold,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.isDark(context)
                ? AppColors.surfaceDark.withValues(alpha: 0.5)
                : Colors.grey[50],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                referenceNumber,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textPrimary(context),
                  fontWeight: AppTextStyles.medium,
                ).copyWith(fontFamily: 'monospace'),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: referenceNumber));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Reference number copied'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.content_copy,
                    size: 18.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
