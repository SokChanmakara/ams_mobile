import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_provider.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/invoice_detail_state.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/data/model/payment_status_step_model.dart';
import 'payment_page.dart';
import '../widgets/invoice_detail/invoice_detail_header.dart';
// import '../widgets/invoice_detail/invoice_status_chip.dart';
import '../widgets/invoice_detail/balance_due_card.dart';
import '../widgets/invoice_detail/invoice_details_section.dart';
import '../widgets/invoice_detail/payment_status_timeline.dart';
import '../widgets/invoice_detail/invoice_bottom_actions.dart';

/// Invoice Overview Screen
/// Displays detailed invoice information with payment status timeline
class InvoiceDetailPage extends ConsumerStatefulWidget {
  final String? billingId;
  final String invoiceNumber;
  final String balanceDue;
  final String status;
  final String description;
  final String billingType;
  final String billingPeriod;
  final String condominium;
  final List<PaymentStatusStep> statusSteps;

  const InvoiceDetailPage({
    super.key,
    this.billingId,
    this.billingType = 'N/A',
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
  ConsumerState<InvoiceDetailPage> createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends ConsumerState<InvoiceDetailPage> {
  @override
  void initState() {
    super.initState();
    // Fetch billing details if billingId is provided
    if (widget.billingId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(invoiceDetailNotifierProvider.notifier)
            .fetchBillingDetail(billingId: widget.billingId!);
      });
    }
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${date.day} ${months[date.month - 1]}';
    } catch (e) {
      return dateStr;
    }
  }

  String _formatBillingPeriod(String start, String end) {
    try {
      return '${_formatDate(start)} - ${_formatDate(end)}';
    } catch (e) {
      return '$start - $end';
    }
  }

  List<PaymentStatusStep> _determineStatusSteps(
    String status,
    String? paymentProofStatus,
  ) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const [
          PaymentStatusStep(
            title: 'Invoice Sent',
            subtitle: 'Awaiting payment',
            icon: Icons.send_outlined,
            status: StepStatus.current,
          ),
          PaymentStatusStep(
            title: 'Payment Pending',
            icon: Icons.pending_outlined,
            status: StepStatus.inactive,
          ),
          PaymentStatusStep(
            title: 'Invoice Cleared',
            icon: Icons.receipt_long_outlined,
            status: StepStatus.inactive,
          ),
        ];

      case 'paid':
        if (paymentProofStatus == 'pending') {
          return const [
            PaymentStatusStep(
              title: 'Payment Proof Submitted',
              subtitle: 'Awaiting approval',
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
          ];
        } else {
          return const [
            PaymentStatusStep(
              title: 'Payment Received',
              subtitle: 'Payment successfully processed',
              icon: Icons.check_circle_outline,
              status: StepStatus.completed,
            ),
            PaymentStatusStep(
              title: 'Invoice Cleared',
              subtitle: 'All payments completed',
              icon: Icons.receipt_long_outlined,
              status: StepStatus.completed,
            ),
          ];
        }

      default:
        return widget.statusSteps;
    }
  }

  @override
  Widget build(BuildContext context) {
    final invoiceState = ref.watch(invoiceDetailNotifierProvider);

    // If billingId is provided and we have loaded data, use it
    if (widget.billingId != null && invoiceState is InvoiceDetailLoaded) {
      final billing = invoiceState.data.billing;
      final statusSteps = _determineStatusSteps(
        billing.status,
        billing.paymentProofStatus,
      );

      return _buildContent(
        context,
        invoiceNumber: billing.invoiceNumber,
        balanceDue: billing.formattedBalanceAmount,
        billingType: billing.billingTypeDisplayName,
        description: billing.description,
        billingPeriod: _formatBillingPeriod(
          billing.billingPeriodStart,
          billing.billingPeriodEnd,
        ),
        condominium: billing.unit.condominium.name,
        statusSteps: statusSteps,
        isLoading: false,
        error: null,
      );
    } else if (widget.billingId != null &&
        invoiceState is InvoiceDetailLoading) {
      return _buildContent(
        context,
        invoiceNumber: widget.invoiceNumber,
        balanceDue: widget.balanceDue,
        billingType: widget.billingType ?? 'N/A',
        description: widget.description,
        billingPeriod: widget.billingPeriod,
        condominium: widget.condominium,
        statusSteps: widget.statusSteps,
        isLoading: true,
        error: null,
      );
    } else if (widget.billingId != null &&
        invoiceState is InvoiceDetailFailure) {
      return _buildContent(
        context,
        invoiceNumber: widget.invoiceNumber,
        balanceDue: widget.balanceDue,
        billingType: widget.billingType ?? 'N/A',
        description: widget.description,
        billingPeriod: widget.billingPeriod,
        condominium: widget.condominium,
        statusSteps: widget.statusSteps,
        isLoading: false,
        error: invoiceState.errorMessage,
      );
    }

    // Fallback to default values if no billingId
    return _buildContent(
      context,
      invoiceNumber: widget.invoiceNumber,
      balanceDue: widget.balanceDue,
      billingType: widget.billingType ?? 'N/A',
      description: widget.description,
      billingPeriod: widget.billingPeriod,
      condominium: widget.condominium,
      statusSteps: widget.statusSteps,
      isLoading: false,
      error: null,
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required String invoiceNumber,
    required String balanceDue,
    required String billingType,
    required String description,
    required String billingPeriod,
    required String condominium,
    required List<PaymentStatusStep> statusSteps,
    required bool isLoading,
    required String? error,
  }) {
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

            // Error State
            if (error != null)
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          error,
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Loading or Content
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status Chip
                          // InvoiceStatusChip(status: status),

                          // Balance Due Card
                          Center(child: BalanceDueCard(balanceDue: balanceDue)),

                          // Invoice Details Section
                          InvoiceDetailsSection(
                            billingType: billingType,
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
                transactionId: '23',
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
