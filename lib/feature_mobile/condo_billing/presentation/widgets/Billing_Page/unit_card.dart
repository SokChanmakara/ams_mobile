import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(32.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge and Edit Button
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          SizedBox(height: 20.h),

          // Unit Number
          Row(
            children: [
              Text(
                'Unit 1204',
                style: AppTextStyles.displaySmall(
                  color: AppColors.textPrimary(context),
                  fontWeight: AppTextStyles.bold,
                ),
              ),
              SizedBox(height: 4.h),

              Icon(Icons.arrow_drop_down, size: 30),
            ],
          ),

          // Location
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18.sp,
                color: AppColors.textTertiary(context),
              ),
              SizedBox(width: 6.w),
              Text(
                'Skyline Residences, Tower A',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textSecondary(context),
                  fontWeight: AppTextStyles.medium,
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),

          // Divider
          Container(
            height: 1,
            color: AppColors.divider(context).withValues(alpha: 0.3),
          ),
          SizedBox(height: 24.h),

          // Unit Details
          Row(
            children: [
              // Type
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'TYPE',
                      style: AppTextStyles.overline(
                        color: AppColors.textTertiary(context),
                        fontWeight: AppTextStyles.semiBold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '2 Bd / 2 Ba',
                      style: AppTextStyles.titleMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              Container(
                width: 1,
                height: 32.h,
                color: AppColors.divider(context),
              ),

              // Size
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'SIZE',
                      style: AppTextStyles.overline(
                        color: AppColors.textTertiary(context),
                        fontWeight: AppTextStyles.semiBold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '850',
                          style: AppTextStyles.titleMedium(
                            color: AppColors.textPrimary(context),
                            fontWeight: AppTextStyles.bold,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'sqft',
                          style: AppTextStyles.caption(
                            color: AppColors.textTertiary(context),
                            fontWeight: AppTextStyles.medium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
