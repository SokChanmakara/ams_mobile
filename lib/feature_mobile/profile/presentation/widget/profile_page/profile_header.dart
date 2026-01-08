import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/widgets/image_loader.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_state.dart';
import 'package:flutter/material.dart';

/// Profile header widget displaying user avatar, name, and unit info
class ProfileHeader extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final UnitState unitState;

  const ProfileHeader({
    super.key,
    required this.name,
    this.imageUrl,
    required this.unitState,
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
          unitState is UnitLoaded &&
                  (unitState as UnitLoaded).selectedUnit != null
              ? 'Unit ${(unitState as UnitLoaded).selectedUnit!.unitNumber}'
              : 'No unit selected',
          style: AppTextStyles.bodyMedium(
            color: AppColors.textSecondary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return ImageLoader(
      width: 100,
      height: 100,
      radius: BorderRadius.circular(99),
      imageUrl: imageUrl.toString(),
      error: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 3),
        ),
        child: Icon(Icons.person, size: 50, color: AppColors.primary),
      ),
    );
  }
}
