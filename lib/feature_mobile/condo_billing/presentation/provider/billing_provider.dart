import 'package:ams_mobile/feature_mobile/condo_billing/data/repository_imp/billing_repo_imp.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/domain/repository/billing_repository.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_notifier.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_state.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/invoice_detail_notifier.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/invoice_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final billingRepositoryProvider = Provider<BillingRepository>((ref) {
  return BillingRepoImp();
});

final billingNotifierProvider = NotifierProvider<BillingNotifier, BillingState>(
  () {
    return BillingNotifier();
  },
);

final invoiceDetailNotifierProvider =
    NotifierProvider<InvoiceDetailNotifier, InvoiceDetailState>(() {
      return InvoiceDetailNotifier();
    });
