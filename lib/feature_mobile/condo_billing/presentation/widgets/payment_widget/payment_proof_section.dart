import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

/// Payment Proof Section for Payment Page
class PaymentProofSection extends StatelessWidget {
  final String receiptFileName;
  final String receiptFileSize;

  const PaymentProofSection({
    super.key,
    required this.receiptFileName,
    required this.receiptFileSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Payment Proof',
            style: AppTextStyles.titleLarge(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // PDF File Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.border(context).withValues(alpha: 0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            children: [
              // File Icon
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.description,
                  size: 24.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 12.w),

              // File Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receiptFileName,
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '$receiptFileSize • Digital Signature Verified',
                      style: AppTextStyles.caption(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),

              // Download Button
              GestureDetector(
                onTap: () {
                  // Download functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Downloading receipt...'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.download,
                    size: 24.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // Receipt Preview Image
        GestureDetector(
          onTap: () {
            // Show full preview
            _showReceiptPreview(context);
          },
          child: Container(
            width: double.infinity,
            height: 240.h,
            decoration: BoxDecoration(
              color: AppColors.isDark(context)
                  ? AppColors.surfaceDark
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.border(context).withValues(alpha: 0.3),
              ),
            ),
            child: Stack(
              children: [
                // Receipt Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCGLDDxyrtk3xZRJB4tZpyzIN0wj98kXrS_EZAxTLn6O7ukkeQ50V6Z_EwDw7In_Zpxx-f5eY8SvySwWAOHcOs5OUZxFimBYHaIjugnaIOJVXbJ8b0Hxd27mz1BcRyc6FYq5SAghoKQ3IDcoJ68LmErNxM-HMtNk8fRfyYOR6nlzTlJvMhFgU9uEv9d64Pv0loi4UhgkDCsAR23mJgDI2gXSz_XT7f3C9j84oJjJenhG3f4pwPYHo-e6RYyKhzkplZHLQLEiHcRzM4',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.8),
                  ),
                ),

                // Hover Overlay
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.zoom_in, color: Colors.white, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Tap to Preview',
                            style: AppTextStyles.bodyMedium(
                              color: Colors.white,
                              fontWeight: AppTextStyles.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showReceiptPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(20.w),
        child: Stack(
          children: [
            // Receipt Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCGLDDxyrtk3xZRJB4tZpyzIN0wj98kXrS_EZAxTLn6O7ukkeQ50V6Z_EwDw7In_Zpxx-f5eY8SvySwWAOHcOs5OUZxFimBYHaIjugnaIOJVXbJ8b0Hxd27mz1BcRyc6FYq5SAghoKQ3IDcoJ68LmErNxM-HMtNk8fRfyYOR6nlzTlJvMhFgU9uEv9d64Pv0loi4UhgkDCsAR23mJgDI2gXSz_XT7f3C9j84oJjJenhG3f4pwPYHo-e6RYyKhzkplZHLQLEiHcRzM4',
                fit: BoxFit.contain,
              ),
            ),

            // Close Button
            Positioned(
              top: 16.h,
              right: 16.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
