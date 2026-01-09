import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentQrSection extends StatelessWidget {
  final String invoiceNumber;
  final VoidCallback onDownloadQRCode;

  const PaymentQrSection({
    super.key,
    required this.invoiceNumber,
    required this.onDownloadQRCode,
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
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Section Title
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.qr_code_2_rounded,
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
                      'Scan to Pay',
                      style: AppTextStyles.titleMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    Text(
                      'Use your banking app to scan',
                      style: AppTextStyles.caption(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // QR Code Display
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.border(context).withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                // Placeholder for QR Code
                // Replace with: QrImageView(data: qrCodeData, size: 200.w)
                Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.qr_code_2,
                    size: 120.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  invoiceNumber,
                  style: AppTextStyles.labelLarge(
                    color: AppColors.textSecondary(context),
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Download Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onDownloadQRCode,
              icon: Icon(Icons.download_rounded, size: 20.sp),
              label: const Text('Download QR Code'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
