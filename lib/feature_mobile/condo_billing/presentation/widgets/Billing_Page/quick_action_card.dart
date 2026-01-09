import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/quick_action_button_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickAction(icon: Icons.description_outlined, label: 'Deed'),
      QuickAction(icon: Icons.history_outlined, label: 'History'),
      QuickAction(icon: Icons.warning_outlined, label: 'Report'),
      QuickAction(icon: Icons.more_horiz, label: 'More'),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.85,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return QuickActionButtonCard(action: action);
      },
    );
  }
}
