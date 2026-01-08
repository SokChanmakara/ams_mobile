import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/quick_access_item.dart';
import 'package:flutter/material.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: AppTextStyles.h4(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: .9,
            children: [
              QuickAccessItem(
                icon: Icons.calendar_month_outlined,
                label: 'Amenities',
                onTap: () {},
                bgColor: AppColors.shadowLight,
                iconColor: AppColors.primary,
              ),
              QuickAccessItem(
                icon: Icons.build_outlined,
                label: 'Report Issue',
                onTap: () {},
                bgColor: AppColors.shadowLight,
                iconColor: AppColors.primary,
              ),
              QuickAccessItem(
                icon: Icons.receipt_long_outlined,
                label: 'My Bills',
                onTap: () {
                  NavigationService.push('/Bill-Detail');
                },
                bgColor: AppColors.shadowLight,
                iconColor: AppColors.primary,
              ),
              QuickAccessItem(
                icon: Icons.qr_code_2_outlined,
                label: 'Gate Pass',
                onTap: () {},
                bgColor: AppColors.shadowLight,
                iconColor: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
