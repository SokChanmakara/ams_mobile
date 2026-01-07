import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final String unitInfo;
  final String? imageUrl;
  const HomeHeader({
    super.key,
    required this.name,
    required this.unitInfo,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background(context).withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: AppColors.divider(context), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Profile Picture with Online Status
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.border(context),
                    width: 2,
                  ),
                  image: imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: imageUrl == null ? AppColors.surface(context) : null,
                ),
                child: imageUrl == null
                    ? Icon(
                        Icons.person,
                        color: AppColors.textSecondary(context),
                        size: 24,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.surface(context),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.h5(
                    color: AppColors.textPrimary(context),
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
                Text(
                  unitInfo,
                  style: AppTextStyles.caption(
                    color: AppColors.textSecondary(context),
                    fontWeight: AppTextStyles.medium,
                  ),
                ),
              ],
            ),
          ),
          // Notification Button
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow(context),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textPrimary(context),
                  ),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.surface(context),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
