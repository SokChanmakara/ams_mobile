import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final String name;
  final String unitInfo;
  final String? imageUrl;

  const HomeContent({
    super.key,
    required this.name,
    required this.unitInfo,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1E2936) : Colors.white;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _buildHeader(isDark, surfaceColor, name, unitInfo, imageUrl),
          ),

          // Scrollable Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildAnnouncementsSection(isDark, surfaceColor),
                const SizedBox(height: 8),
                _buildQuickAccessSection(isDark, surfaceColor),
                const SizedBox(height: 24),
                _buildMyActivitySection(isDark, surfaceColor),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    bool isDark,
    Color surfaceColor,
    String name,
    String unitInfo,
    String? imageUrl,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (isDark ? const Color(0xFF101922) : const Color(0xFFF6F7F8))
            .withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.white10 : Colors.black12,
            width: 0.5,
          ),
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
                    color: isDark ? Colors.grey[700]! : Colors.white,
                    width: 2,
                  ),
                  image: imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: imageUrl == null
                      ? (isDark ? Colors.grey[800] : Colors.grey[300])
                      : null,
                ),
                child: imageUrl == null
                    ? Icon(
                        Icons.person,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
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
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? const Color(0xFF1E2936) : Colors.white,
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0D141B),
                  ),
                ),
                Text(
                  unitInfo,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : const Color(0xFF4C739A),
                    fontWeight: FontWeight.w500,
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
                  color: surfaceColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: isDark ? Colors.white : const Color(0xFF0D141B),
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
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: surfaceColor, width: 1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsSection(bool isDark, Color surfaceColor) {
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0D141B),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Horizontal Scrolling Cards
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              _buildAnnouncementCard(
                isDark,
                surfaceColor,
                'Elevator Maintenance',
                'Scheduled for Oct 12, 10 AM - 2 PM.',
                'MAINTENANCE',
                Colors.black.withValues(alpha: 0.6),
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBzsbKIiVvCMw2L3NfFqvAZH05BtYzyGg8E5tr0tbzviIWfeVKct3dya4xIgsvGgkMv2Dh_jnyoyW8Eu9JvZkiEw06D43miUcAvfjGwW287cC2p7_32zdMv3NJDFPtIyTfEl1tBU5ewNaH9ICyl82ZU5EDoShJOq4-YU44N3HkQgpKZoqXyLMkz2y4kfnaUERvHOk_PrpJla1MQSK2HmqxYd7mOc9GMC5cH06zQoOy6j6bv6FI-DePEP3SyDX1AA5K5de29B292KfMF',
              ),
              const SizedBox(width: 16),
              _buildAnnouncementCard(
                isDark,
                surfaceColor,
                'Community BBQ',
                'Join us this Sunday at the roof deck!',
                'EVENT',
                const Color(0xFF137FEC).withValues(alpha: 0.9),
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDzgujWaIrrTG3xnelonzhQxshYTOdG-qyoV40Pte-uU1QBk6YibhmeKbVO8icu8I4R7TNjDyvT_Bv_O6_r3VgAjHTPRH5csvIFp9tzrBqEXcviHb14mq4qL-3wbd6lHRQ1bViy8gIAXLcREELuqTNHbNhU7kd7uEK8raHx3nCiAZR-pqpt-Tw9Xfbc_tDjgQqFuqiDlTn4EaMfLJ_4vcehTZILy0btAa9awxYDm92bZMQ1nTnWZF5ezy76aB24pixCjJoWeWCvrwqc',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementCard(
    bool isDark,
    Color surfaceColor,
    String title,
    String description,
    String badge,
    Color badgeColor,
    String imageUrl,
  ) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Badge
          Stack(
            children: [
              Container(
                height: 128,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0D141B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[400] : const Color(0xFF4C739A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessSection(bool isDark, Color surfaceColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF0D141B),
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
              _buildQuickAccessItem(
                isDark,
                surfaceColor,
                Icons.calendar_month_outlined,
                'Amenities',
                Colors.blue[50]!,
                const Color(0xFF137FEC),
              ),
              _buildQuickAccessItem(
                isDark,
                surfaceColor,
                Icons.build_outlined,
                'Report Issue',
                Colors.orange[50]!,
                Colors.orange[600]!,
              ),
              _buildQuickAccessItem(
                isDark,
                surfaceColor,
                Icons.receipt_long_outlined,
                'My Bills',
                Colors.purple[50]!,
                Colors.purple[600]!,
              ),
              _buildQuickAccessItem(
                isDark,
                surfaceColor,
                Icons.qr_code_2_outlined,
                'Gate Pass',
                Colors.teal[50]!,
                Colors.teal[600]!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessItem(
    bool isDark,
    Color surfaceColor,
    IconData icon,
    String label,
    Color bgColor,
    Color iconColor,
  ) {
    return Material(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey[200]!,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
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
                  color: isDark ? iconColor.withValues(alpha: 0.1) : bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isDark ? iconColor.withValues(alpha: 0.8) : iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF0D141B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyActivitySection(bool isDark, Color surfaceColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF0D141B),
            ),
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            isDark,
            surfaceColor,
            Icons.inventory_2_outlined,
            'Package Arrived',
            'Waiting at front desk • 2h ago',
            Colors.green[50]!,
            Colors.green[600]!,
          ),
          const SizedBox(height: 12),
          _buildActivityItem(
            isDark,
            surfaceColor,
            Icons.fitness_center_outlined,
            'Gym Booking',
            'Tomorrow, 7:00 AM - 8:00 AM',
            Colors.blue[50]!,
            const Color(0xFF137FEC),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    bool isDark,
    Color surfaceColor,
    IconData icon,
    String title,
    String subtitle,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark ? iconColor.withValues(alpha: 0.1) : bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDark ? iconColor.withValues(alpha: 0.8) : iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF0D141B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
