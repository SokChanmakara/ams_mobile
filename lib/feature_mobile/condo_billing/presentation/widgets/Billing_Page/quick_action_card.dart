import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(icon: Icons.description_outlined, label: 'Deed'),
      _QuickAction(icon: Icons.history_outlined, label: 'History'),
      _QuickAction(icon: Icons.warning_outlined, label: 'Report'),
      _QuickAction(icon: Icons.more_horiz, label: 'More'),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.85,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return _buildQuickActionButton(context, action);
      },
    );
  }

  Widget _buildQuickActionButton(BuildContext context, _QuickAction action) {
    return InkWell(
      onTap: () {
        // Action handler
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.border(context)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              action.icon,
              size: 24.sp,
              color: AppColors.textSecondary(context),
            ),
          ),
          SizedBox(height: 8.h),

          // Label
          Text(
            action.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall(
              color: AppColors.textSecondary(context),
              fontWeight: AppTextStyles.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;

  _QuickAction({required this.icon, required this.label});
}
