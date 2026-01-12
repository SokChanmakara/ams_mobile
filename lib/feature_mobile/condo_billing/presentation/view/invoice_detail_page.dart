import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'payment_page.dart';
import '../widgets/invoice_detail/payment_status_step_model.dart';
import '../widgets/invoice_detail/invoice_detail_header.dart';
import '../widgets/invoice_detail/invoice_status_chip.dart';
import '../widgets/invoice_detail/balance_due_card.dart';
import '../widgets/invoice_detail/invoice_details_section.dart';
import '../widgets/invoice_detail/payment_status_timeline.dart';
import '../widgets/invoice_detail/invoice_bottom_actions.dart';

/// Invoice Overview Screen
/// Displays detailed invoice information with payment status timeline
class InvoiceDetailPage extends StatelessWidget {
  final String? billingId;
  final String invoiceNumber;
  final String balanceDue;
  final String status;
  final String description;
  final String billingPeriod;
  final String condominium;
  final List<PaymentStatusStep> statusSteps;

  const InvoiceDetailPage({
    super.key,
    this.billingId,
    this.invoiceNumber = 'INV-2601-032831',
    this.balanceDue = '\$25.00',
    this.status = 'Sent',
    this.description = 'Broken toilet repair',
    this.billingPeriod = '14 Jan - 07 Feb',
    this.condominium = 'Sunset Tower',
    this.statusSteps = const [
      PaymentStatusStep(
        title: 'Payment Proof Submitted',
        subtitle: 'Submitted on Feb 08, 10:24 AM',
        icon: Icons.check,
        status: StepStatus.completed,
        hasAction: true,
        actionLabel: 'View Receipt',
      ),
      PaymentStatusStep(
        title: 'Pending Approval',
        subtitle: 'Our team is reviewing your payment',
        icon: Icons.pending_outlined,
        status: StepStatus.current,
      ),
      PaymentStatusStep(
        title: 'Invoice Cleared',
        icon: Icons.receipt_long_outlined,
        status: StepStatus.inactive,
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface(context),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            InvoiceDetailHeader(
              invoiceNumber: invoiceNumber,
              onMorePressed: () => _showMoreOptions(context),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Chip
                    // InvoiceStatusChip(status: status),

                    // Balance Due Card
                    Center(child: BalanceDueCard(balanceDue: balanceDue)),

                    // Invoice Details Section
                    InvoiceDetailsSection(
                      description: description,
                      billingPeriod: billingPeriod,
                      condominium: condominium,
                    ),

                    // Payment Status Timeline
                    PaymentStatusTimeline(statusSteps: statusSteps),

                    SizedBox(height: 100.h), // Space for fixed button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Fixed Bottom Button
      bottomNavigationBar: InvoiceBottomActions(
        balanceDue: balanceDue,
        statusSteps: statusSteps,
        onPayPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentPage(
                invoiceNumber: invoiceNumber,
                amount: balanceDue,
                description: description,
              ),
            ),
          );
        },
        // onContactPressed: () {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: const Text('Contacting property manager...'),
        //       behavior: SnackBarBehavior.floating,
        //       backgroundColor: AppColors.primary,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(12.r),
        //       ),
        //     ),
        //   );
        // },
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.textTertiary(context),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 24.h),
              _buildOptionItem(context, Icons.download, 'Download Invoice'),
              _buildOptionItem(context, Icons.share, 'Share Invoice'),
              _buildOptionItem(context, Icons.print, 'Print Invoice'),
              _buildOptionItem(
                context,
                Icons.report_problem_outlined,
                'Report Issue',
                isLast: true,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    BuildContext context,
    IconData icon,
    String label, {
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label clicked'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(icon, size: 24.sp, color: AppColors.textPrimary(context)),
            SizedBox(width: 16.w),
            Text(
              label,
              style: AppTextStyles.bodyLarge(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
