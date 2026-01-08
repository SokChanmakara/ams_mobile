import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class QuickAccessItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const QuickAccessItem({
    super.key,
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface(context),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border(context)),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.backgroundLight.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.isDark(context)
                      ? iconColor.withValues(alpha: 0.1)
                      : bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.isDark(context)
                      ? iconColor.withValues(alpha: 0.8)
                      : iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: AppTextStyles.labelLarge(
                  color: AppColors.textPrimary(context),
                  fontWeight: AppTextStyles.semiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
