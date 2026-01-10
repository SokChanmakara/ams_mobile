import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_provider.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_header_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_pending_bill_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_unit_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_unit_resource_card.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_provider.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Unit Details & Billing Overview Screen
/// A modern, clean interface for viewing unit information and pending billings
class BillingPage extends ConsumerStatefulWidget {
  const BillingPage({super.key});

  @override
  ConsumerState<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends ConsumerState<BillingPage> {
  String? _previousUnitId;

  @override
  void initState() {
    super.initState();
    // Fetch billing data on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final unitState = ref.read(unitNotifierProvider);
      if (unitState is UnitLoaded && unitState.selectedUnit != null) {
        _previousUnitId = unitState.selectedUnit!.id;
        ref
            .read(billingNotifierProvider.notifier)
            .fetchPendingBillings(unitId: unitState.selectedUnit!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final unitState = ref.watch(unitNotifierProvider);
    final selectedUnit = unitState is UnitLoaded
        ? unitState.selectedUnit
        : null;

    // Fetch billing data when unit changes
    if (selectedUnit != null && selectedUnit.id != _previousUnitId) {
      _previousUnitId = selectedUnit.id;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(billingNotifierProvider.notifier)
            .fetchPendingBillings(unitId: selectedUnit.id);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.white,
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
                    if (selectedUnit != null)
                      BillingUnitCard(unit: selectedUnit)
                    else
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: Text(
                            'No unit selected',
                            style: TextStyle(
                              color: AppColors.textSecondary(context),
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
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
