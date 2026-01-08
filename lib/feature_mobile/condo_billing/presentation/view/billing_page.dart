import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/allocated_asset_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_header.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/bottom_payment_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/fee_breakdown_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/quick_action_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/unit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            BillingHeader(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Unit Card
                    UnitCard(),
                    SizedBox(height: 24.h),

                    // Quick Actions Grid
                    QuickActionCard(),
                    SizedBox(height: 24.h),

                    // Allocated Assets Section
                    AllocatedAssetCard(),
                    SizedBox(height: 24.h),

                    // Fee Breakdown Section
                    FeeBreakdownCard(),
                    SizedBox(height: 100.h), // Space for fixed button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Fixed Bottom Button
      bottomNavigationBar: BottomPaymentCard(),
    );
  }
}
