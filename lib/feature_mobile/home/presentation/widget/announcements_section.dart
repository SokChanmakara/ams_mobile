import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/announcement_card.dart';
import 'package:flutter/material.dart';

class AnnouncementsSection extends StatelessWidget {
  const AnnouncementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Announcements',
                style: AppTextStyles.h4(
                  color: AppColors.textPrimary(context),
                  fontWeight: AppTextStyles.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: AppTextStyles.labelLarge(
                    color: AppColors.primary,
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Horizontal Scrolling Cards
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              AnnouncementCard(
                title: 'Elevator Maintenance',
                description: 'Scheduled for Oct 12, 10 AM - 2 PM.',
                badge: 'MAINTENANCE',
                badgeColor: Colors.black.withValues(alpha: 0.6),
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBzsbKIiVvCMw2L3NfFqvAZH05BtYzyGg8E5tr0tbzviIWfeVKct3dya4xIgsvGgkMv2Dh_jnyoyW8Eu9JvZkiEw06D43miUcAvfjGwW287cC2p7_32zdMv3NJDFPtIyTfEl1tBU5ewNaH9ICyl82ZU5EDoShJOq4-YU44N3HkQgpKZoqXyLMkz2y4kfnaUERvHOk_PrpJla1MQSK2HmqxYd7mOc9GMC5cH06zQoOy6j6bv6FI-DePEP3SyDX1AA5K5de29B292KfMF',
              ),
              const SizedBox(width: 16),
              AnnouncementCard(
                title: 'Community BBQ',
                description: 'Join us this Sunday at the roof deck!',
                badge: 'EVENT',
                badgeColor: AppColors.primary.withValues(alpha: 0.9),
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDzgujWaIrrTG3xnelonzhQxshYTOdG-qyoV40Pte-uU1QBk6YibhmeKbVO8icu8I4R7TNjDyvT_Bv_O6_r3VgAjHTPRH5csvIFp9tzrBqEXcviHb14mq4qL-3wbd6lHRQ1bViy8gIAXLcREELuqTNHbNhU7kd7uEK8raHx3nCiAZR-pqpt-Tw9Xfbc_tDjgQqFuqiDlTn4EaMfLJ_4vcehTZILy0btAa9awxYDm92bZMQ1nTnWZF5ezy76aB24pixCjJoWeWCvrwqc',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
