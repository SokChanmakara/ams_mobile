import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

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
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAfrP5_FGFDQdCv_MtkmyKRcAYlgaYUUGCb5JGRiK70eVeHzoIuSypr-O89zo-wcuw8eLVwss_ggSAQAMdqjTqCAqZq_FZbzPYLPZcnAGUpf4FDzK0CjV7APWFWhapQm_3Z68-b3VTMDXHgn3sycgwhliNi0esGmsrKWo9k3ShO_hIYmIO6xtrhx877uAMRA2GlXBeEHFnm0qL1zhAyVCeGINZLpSytOEst78KspMj2Z8EiNkAeE9yQaSb6BsaQ084M4CFar5qR40f8',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
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
                  'Welcome home, Sarah',
                  style: AppTextStyles.h5(
                    color: AppColors.textPrimary(context),
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
                Text(
                  'Unit 402 • The Azure Tower',
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
