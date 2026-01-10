import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_unit_item_card.dart';
import 'package:ams_mobile/feature_mobile/home/data/model/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingUnitCard extends StatelessWidget {
  final UnitModel unit;

  const BillingUnitCard({super.key, required this.unit});

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
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Unit Number and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unit Number and Building
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unit ${unit.unitNumber}',
                      style: AppTextStyles.displaySmall(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.apartment_outlined,
                          size: 18.sp,
                          color: AppColors.textSecondary(context),
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            unit.condominium.name,
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.textSecondary(context),
                              fontWeight: AppTextStyles.medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),

              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: unit.status.toLowerCase() == 'occupied'
                      ? AppColors.successLight
                      : AppColors.warningLight,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color:
                        (unit.status.toLowerCase() == 'occupied'
                                ? AppColors.success
                                : AppColors.warning)
                            .withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  unit.status.toUpperCase(),
                  style: AppTextStyles.overline(
                    color: unit.status.toLowerCase() == 'occupied'
                        ? AppColors.successDark
                        : AppColors.warningDark,
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
              ),
            ],
          ),

          // Divider
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 24.h),
            color: AppColors.divider(context).withValues(alpha: 0.3),
          ),

          // Unit Details Grid
          Row(
            children: [
              // Floor
              Expanded(
                child: BillingUnitItemCard(
                  label: 'FLOOR',
                  value: unit.floor.toString(),
                ),
              ),

              // Beds
              Expanded(
                child: BillingUnitItemCard(
                  label: 'BEDS',
                  value: '${unit.bedrooms} BR',
                ),
              ),

              // Baths
              Expanded(
                child: BillingUnitItemCard(
                  label: 'BATHS',
                  value: '${unit.bathrooms} BA',
                ),
              ),

              // Area
              Expanded(
                child: BillingUnitItemCard(
                  label: 'AREA',
                  value: unit.areaSqft,
                  suffix: 'sqft',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
