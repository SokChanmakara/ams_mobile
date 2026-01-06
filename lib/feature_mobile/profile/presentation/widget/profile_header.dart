import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Profile header widget displaying user avatar, name, and unit info
class ProfileHeader extends StatelessWidget {
  final String name;
  final String unitInfo;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.unitInfo,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAvatar(),
        const SizedBox(height: 16),
        Text(
          name,
          style: AppTextStyles.headlineMedium(fontWeight: AppTextStyles.bold),
        ),
        const SizedBox(height: 4),
        Text(
          unitInfo,
          style: AppTextStyles.bodyMedium(
            color: AppColors.textSecondary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 3),
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
        color: imageUrl == null ? AppColors.primarySurface : null,
      ),
      child: imageUrl == null
          ? Icon(Icons.person, size: 50, color: AppColors.primary)
          : null,
    );
  }
}
