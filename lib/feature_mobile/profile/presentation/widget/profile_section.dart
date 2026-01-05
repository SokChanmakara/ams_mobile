import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Profile section widget
/// Groups related profile options under a section title
class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.labelLarge(
            color: AppColors.textSecondary(context),
            fontWeight: AppTextStyles.semiBold,
          ),
        ),
        SizedBox(height: 12.h),
        ...children.map((child) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: child,
            )),
      ],
    );
  }
}
