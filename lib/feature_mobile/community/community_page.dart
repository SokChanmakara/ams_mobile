import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1E2936) : Colors.white;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Community',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0D141B),
                ),
              ),
            ),

            // Community Features
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildCommunityCard(
                    isDark,
                    surfaceColor,
                    Icons.event_outlined,
                    'Events',
                    'Upcoming community events',
                    '3 upcoming',
                    const Color(0xFF137FEC),
                  ),
                  const SizedBox(height: 12),
                  _buildCommunityCard(
                    isDark,
                    surfaceColor,
                    Icons.forum_outlined,
                    'Discussion Board',
                    'Chat with your neighbors',
                    '12 new posts',
                    Colors.purple[600]!,
                  ),
                  const SizedBox(height: 12),
                  _buildCommunityCard(
                    isDark,
                    surfaceColor,
                    Icons.volunteer_activism_outlined,
                    'Marketplace',
                    'Buy and sell with neighbors',
                    '8 new items',
                    Colors.orange[600]!,
                  ),
                  const SizedBox(height: 12),
                  _buildCommunityCard(
                    isDark,
                    surfaceColor,
                    Icons.groups_outlined,
                    'Directory',
                    'Find residents and staff',
                    null,
                    Colors.teal[600]!,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityCard(
    bool isDark,
    Color surfaceColor,
    IconData icon,
    String title,
    String subtitle,
    String? badge,
    Color iconColor,
  ) {
    return Material(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
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
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark
                      ? iconColor.withValues(alpha: 0.1)
                      : iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF0D141B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: iconColor,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
