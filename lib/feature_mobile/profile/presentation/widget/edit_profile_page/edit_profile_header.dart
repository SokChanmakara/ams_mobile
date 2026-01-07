import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background(context).withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(color: AppColors.divider(context), width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 64,
            child: TextButton(
              onPressed: () => NavigationService.goBack(),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                'Cancel',
                style: AppTextStyles.bodyLarge(
                  color: AppColors.textSecondary(context),
                  fontWeight: AppTextStyles.medium,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Edit Profile',
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineSmall(
                fontWeight: AppTextStyles.bold,
              ),
            ),
          ),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}
