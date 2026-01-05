import 'package:ams_mobile/feature_mobile/home/presentation/widget/announcements_section.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/home_bottom_nav_bar.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/home_header.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/my_activity_section.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/quick_access_section.dart';
import 'package:flutter/material.dart';

class CondoHomePage extends StatefulWidget {
  const CondoHomePage({super.key});

  @override
  State<CondoHomePage> createState() => _CondoHomePageState();
}

class _CondoHomePageState extends State<CondoHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            HomeHeader(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    AnnouncementsSection(),
                    SizedBox(height: 8),
                    QuickAccessSection(),
                    SizedBox(height: 24),
                    MyActivitySection(),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(),
    );
  }
}
