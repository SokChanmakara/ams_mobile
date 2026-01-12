import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_provider.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_state.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/Billing_Page/billing_invoice_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingPendingBillCard extends ConsumerStatefulWidget {
  final Function(double amount, int count)? onSelectionChanged;

  const BillingPendingBillCard({super.key, this.onSelectionChanged});

  @override
  ConsumerState<BillingPendingBillCard> createState() =>
      _BillingPendingBillCardState();
}

class _BillingPendingBillCardState
    extends ConsumerState<BillingPendingBillCard> {
  final Set<String> _selectedBillingIds = {};

  void _notifySelectionChanged(List<dynamic> pendingBillings) {
    final selectedTotal = pendingBillings
        .where((b) => _selectedBillingIds.contains(b.id))
        .fold<double>(0.0, (sum, billing) {
          final amount = double.tryParse(billing.balanceAmount) ?? 0.0;
          return sum + amount;
        });

    widget.onSelectionChanged?.call(selectedTotal, _selectedBillingIds.length);
  }

  @override
  Widget build(BuildContext context) {
    final billingState = ref.watch(billingNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PENDING BILLINGS',
                style: AppTextStyles.overline(
                  color: AppColors.textTertiary(context),
                  fontWeight: AppTextStyles.bold,
                ),
              ),

              // Invoice Count Badge - Show only pending billings count
              if (billingState is BillingLoaded)
                Builder(
                  builder: (context) {
                    final pendingCount = billingState.data.billings
                        .where(
                          (billing) =>
                              billing.status.toLowerCase() == 'pending',
                        )
                        .length;
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.isDark(context)
                            ? AppColors.surfaceDark
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '$pendingCount Invoice${pendingCount != 1 ? 's' : ''}',
                        style: AppTextStyles.labelSmall(
                          color: AppColors.primary,
                          fontWeight: AppTextStyles.semiBold,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),

        // Loading State
        if (billingState is BillingLoading)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),

        // Error State
        if (billingState is BillingFailure)
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: AppColors.error,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    billingState.errorMessage,
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.textSecondary(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

        // Initial State
        if (billingState is BillingInitial)
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.surface(context),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Center(
              child: Text(
                'Select a unit to view billings',
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textSecondary(context),
                ),
              ),
            ),
          ),

        // Loaded State with Data
        if (billingState is BillingLoaded) ...[
          // Total Outstanding Card - Calculate only for pending billings
          Builder(
            builder: (context) {
              final pendingBillings = billingState.data.billings
                  .where((billing) => billing.status.toLowerCase() == 'pending')
                  .toList();

              final totalPendingOutstanding = pendingBillings.fold<double>(
                0.0,
                (sum, billing) {
                  final amount = double.tryParse(billing.balanceAmount) ?? 0.0;
                  return sum + amount;
                },
              );

              // Calculate selected total
              final selectedTotal = _selectedBillingIds.isEmpty
                  ? totalPendingOutstanding
                  : pendingBillings
                        .where((b) => _selectedBillingIds.contains(b.id))
                        .fold<double>(0.0, (sum, billing) {
                          final amount =
                              double.tryParse(billing.balanceAmount) ?? 0.0;
                          return sum + amount;
                        });

              return Container(
                padding: EdgeInsets.all(24.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: AppColors.border(context).withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 15,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total Amount
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedBillingIds.isEmpty
                                ? 'Total Outstanding'
                                : 'Selected Amount (${_selectedBillingIds.length})',
                            style: AppTextStyles.caption(
                              color: AppColors.textSecondary(context),
                              fontWeight: AppTextStyles.medium,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '\$${selectedTotal.toStringAsFixed(2)}',
                            style: AppTextStyles.displaySmall(
                              color: AppColors.textPrimary(context),
                              fontWeight: AppTextStyles.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Icon
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: AppColors.isDark(context)
                            ? AppColors.surfaceDark
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 28.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Select All / Deselect All button
          Builder(
            builder: (context) {
              final pendingBillings = billingState.data.billings
                  .where((billing) => billing.status.toLowerCase() == 'pending')
                  .toList();

              if (pendingBillings.isEmpty) return const SizedBox.shrink();

              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (_selectedBillingIds.length ==
                            pendingBillings.length) {
                          _selectedBillingIds.clear();
                        } else {
                          _selectedBillingIds.clear();
                          _selectedBillingIds.addAll(
                            pendingBillings.map((b) => b.id),
                          );
                        }
                        _notifySelectionChanged(pendingBillings);
                      });
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.isDark(context)
                            ? AppColors.surfaceDark
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.border(
                            context,
                          ).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon(
                          //   _selectedBillingIds.length == pendingBillings.length
                          //       ? Icons.deselect
                          //       : Icons.select_all,
                          //   size: 18.sp,
                          //   color: AppColors.primary,
                          // ),
                          SizedBox(width: 8.w),
                          Text(
                            _selectedBillingIds.length == pendingBillings.length
                                ? 'Deselect All'
                                : 'Select All',
                            style: AppTextStyles.labelMedium(
                              color: AppColors.primary,
                              fontWeight: AppTextStyles.semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Invoice List - Filter to show only pending billings
          if (billingState.data.billings
              .where((billing) => billing.status.toLowerCase() == 'pending')
              .isNotEmpty)
            Column(
              children: billingState.data.billings
                  .where((billing) => billing.status.toLowerCase() == 'pending')
                  .map((billing) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: BillingInvoiceItemCard(
                        icon: billing.billingTypeIcon,
                        invoiceNumber: billing.invoiceNumber,
                        description:
                            '${billing.description} • ${_formatDate(billing.billingDate)}',
                        amount: billing.formattedBalanceAmount,
                        billingId: billing.id,
                        isSelected: _selectedBillingIds.contains(billing.id),
                        onSelectionChanged: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedBillingIds.add(billing.id);
                            } else {
                              _selectedBillingIds.remove(billing.id);
                            }
                            final pendingBillings = billingState.data.billings
                                .where(
                                  (billing) =>
                                      billing.status.toLowerCase() == 'pending',
                                )
                                .toList();
                            _notifySelectionChanged(pendingBillings);
                          });
                        },
                      ),
                    );
                  })
                  .toList(),
            )
          else
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.surface(context),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  'No pending billings',
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ),
            ),
        ],
      ],
    );
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
      return '${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}
