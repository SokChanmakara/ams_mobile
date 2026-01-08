import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/activity_item.dart';
import 'package:flutter/material.dart';

class MyActivitySection extends StatelessWidget {
  const MyActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: AppTextStyles.h4(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.bold,
            ),
          ),
          const SizedBox(height: 16),
          ActivityItem(
            icon: Icons.inventory_2_outlined,
            title: 'Package Arrived',
            subtitle: 'Waiting at front desk • 2h ago',
            bgColor: Colors.green[50]!,
            iconColor: AppColors.success,
          ),
          const SizedBox(height: 12),
          ActivityItem(
            icon: Icons.fitness_center_outlined,
            title: 'Gym Booking',
            subtitle: 'Tomorrow, 7:00 AM - 8:00 AM',
            bgColor: Colors.blue[50]!,
            iconColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
