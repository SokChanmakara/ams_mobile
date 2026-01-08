import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_provider.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/announcements_section.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/home_header.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/my_activity_section.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/quick_access_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeContent extends ConsumerWidget {
  final String name;
  final String? imageUrl;

  const HomeContent({super.key, required this.name, this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitState = ref.watch(unitNotifierProvider);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: HomeHeader(
              name: name,
              imageUrl: imageUrl,
              unitState: unitState,
            ),
          ),

          // Scrollable Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                AnnouncementsSection(),
                const SizedBox(height: 8),
                QuickAccessSection(),
                const SizedBox(height: 24),
                MyActivitySection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
