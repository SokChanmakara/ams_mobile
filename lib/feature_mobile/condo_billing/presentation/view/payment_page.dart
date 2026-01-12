import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_widget/bottom_actions.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_widget/payment_navigation_bar.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_widget/payment_proof_section.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_widget/settlement_details_card.dart';

/// Transaction Receipt Screen
/// Displays detailed payment receipt with settlement details and proof
class PaymentPage extends StatelessWidget {
  final String transactionId;
  final String amount;
  final String settlementNumber;
  final String description;
  final String location;
  final String paymentMethod;
  final String dateTime;
  final String referenceNumber;
  final String receiptFileName;
  final String receiptFileSize;
  final String invoiceNumber;

  const PaymentPage({
    super.key,
    required this.transactionId,
    this.amount = '\$1,250.00',
    this.settlementNumber = '#SET-88291',
    this.description = 'Monthly Maintenance - Oct 2023',
    this.location = 'Skyline Heights Apt, Unit 402',
    this.paymentMethod = 'Visa •••• 4242',
    this.dateTime = 'Oct 12, 2:45 PM',
    this.referenceNumber = 'TXN-90210-PRTY-331',
    this.receiptFileName = 'official_receipt_88291.pdf',
    this.receiptFileSize = '1.2 MB',
    this.invoiceNumber = "PM123456",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Column(
          children: [
            // Navigation Bar
            const PaymentNavigationBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Success Status & Amount Card
                    // _buildSuccessCard(context),
                    // SizedBox(height: 24.h),

                    // Settlement Details Card
                    SettlementDetailsCard(
                      settlementNumber: settlementNumber,
                      description: description,
                      location: location,
                      paymentMethod: paymentMethod,
                      dateTime: dateTime,
                      referenceNumber: referenceNumber,
                    ),
                    SizedBox(height: 24.h),

                    // Payment Proof Section
                    PaymentProofSection(
                      receiptFileName: receiptFileName,
                      receiptFileSize: receiptFileSize,
                    ),
                    SizedBox(height: 24.h),

                    // Bottom Actions
                    const BottomActions(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
