import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

/// Header with back button and invoice number
class InvoiceDetailHeader extends StatelessWidget {
  final String invoiceNumber;
  final VoidCallback? onMorePressed;

  const InvoiceDetailHeader({
    super.key,
    required this.invoiceNumber,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        border: Border(
          bottom: BorderSide(
            color: AppColors.border(context).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => NavigationService.goBack(),
            child: Container(
              width: 48.w,
              height: 48.w,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.sp,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),

          // Invoice Number
          Expanded(
            child: Text(
              invoiceNumber,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.bold,
              ),
            ),
          ),

          // More Options Button
          IconButton(
            onPressed: onMorePressed,
            icon: Icon(
              Icons.more_horiz,
              size: 24.sp,
              color: AppColors.textPrimary(context),
            ),
          ),
        ],
      ),
    );
  }
}
