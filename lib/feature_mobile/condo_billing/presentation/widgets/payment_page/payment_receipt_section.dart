import 'dart:io';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentReceiptSection extends StatelessWidget {
  final File? uploadedReceipt;
  final bool isUploading;
  final VoidCallback onPickReceipt;
  final VoidCallback onRemoveReceipt;

  const PaymentReceiptSection({
    super.key,
    required this.uploadedReceipt,
    required this.isUploading,
    required this.onPickReceipt,
    required this.onRemoveReceipt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: uploadedReceipt != null
              ? AppColors.success.withValues(alpha: 0.5)
              : AppColors.border(context).withValues(alpha: 0.3),
          width: uploadedReceipt != null ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: uploadedReceipt != null
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  uploadedReceipt != null
                      ? Icons.check_circle_outline
                      : Icons.upload_file_outlined,
                  color: uploadedReceipt != null
                      ? AppColors.success
                      : AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Receipt',
                      style: AppTextStyles.titleMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    Text(
                      uploadedReceipt != null
                          ? 'Receipt uploaded successfully'
                          : 'Upload proof of payment',
                      style: AppTextStyles.caption(
                        color: uploadedReceipt != null
                            ? AppColors.success
                            : AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Receipt Preview or Upload Button
          if (uploadedReceipt != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.file(
                    uploadedReceipt!,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: onRemoveReceipt,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            GestureDetector(
              onTap: isUploading ? null : onPickReceipt,
              child: Container(
                height: 160.h,
                decoration: BoxDecoration(
                  color: AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.border(context).withValues(alpha: 0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isUploading)
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        )
                      else ...[
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 48.sp,
                          color: AppColors.textSecondary(context),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Tap to upload receipt',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.textSecondary(context),
                            fontWeight: AppTextStyles.medium,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'PNG, JPG or PDF',
                          style: AppTextStyles.caption(
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
