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
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              QuickAccessItem(
                icon: Icons.calendar_month_outlined,
                label: 'Amenities',
                bgColor: Colors.blue[50]!,
                iconColor: AppColors.primary,
              ),
              QuickAccessItem(
                icon: Icons.build_outlined,
                label: 'Report Issue',
                bgColor: Colors.orange[50]!,
                iconColor: Colors.orange[600]!,
              ),
              QuickAccessItem(
                icon: Icons.receipt_long_outlined,
                label: 'My Bills',
                bgColor: Colors.purple[50]!,
                iconColor: Colors.purple[600]!,
              ),
              QuickAccessItem(
                icon: Icons.qr_code_2_outlined,
                label: 'Gate Pass',
                bgColor: Colors.teal[50]!,
                iconColor: Colors.teal[600]!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
