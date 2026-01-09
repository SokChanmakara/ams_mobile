import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_header_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_pending_bill_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_unit_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_unit_resource_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Unit Details & Billing Overview Screen
/// A modern, clean interface for viewing unit information and pending billings
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
            BillingHeaderCard(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 120.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Unit Information Card
                    BillingUnitCard(),
                    SizedBox(height: 32.h),

                    // Pending Billings Section
                    BillingPendingBillCard(),
                    SizedBox(height: 32.h),

                    // Unit Resources
                    BillingUnitResourceCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Fixed Bottom Payment Button
      bottomNavigationBar: const BottomPaymentButton(),
    );
  }
}
