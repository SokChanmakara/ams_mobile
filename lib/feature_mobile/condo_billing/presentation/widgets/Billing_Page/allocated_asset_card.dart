import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllocatedAssetCard extends StatelessWidget {
  const AllocatedAssetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 16.h),
          child: Text(
            'ALLOCATED ASSETS',
            style: AppTextStyles.overline(
              color: AppColors.textTertiary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),
        ),

        // Assets Grid
        Row(
          children: [
            // Parking Spot
            Expanded(
              // child: _buildAssetCard(
              //   context,
              //   icon: Icons.directions_car_outlined,
              //   label: 'Parking Spot',
              //   value: 'P2-45',
              // ),
              child: AssetCard(
                icon: Icons.directions_car_outlined,
                label: 'Parking Spot',
                value: 'P2-45',
              ),
            ),
            SizedBox(width: 16.w),

            // Storage Locker
            Expanded(
              // child: _buildAssetCard(
              //   context,
              //   icon: Icons.lock_outlined,
              //   label: 'Storage Locker',
              //   value: 'L-102',
              // ),
              child: AssetCard(
                icon: Icons.lock_outlined,
                label: 'Storage Locker',
                value: 'L-102',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
