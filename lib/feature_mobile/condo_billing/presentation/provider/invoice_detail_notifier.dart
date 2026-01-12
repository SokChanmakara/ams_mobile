import 'package:ams_mobile/feature_mobile/condo_billing/domain/repository/billing_repository.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_provider.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/invoice_detail_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceDetailNotifier extends Notifier<InvoiceDetailState> {
  late final BillingRepository _repository;

  @override
  InvoiceDetailState build() {
    _repository = ref.read(billingRepositoryProvider);
    return InvoiceDetailInitial();
  }

  Future<void> fetchBillingDetail({required String billingId}) async {
    state = InvoiceDetailLoading();
    try {
      final response = await _repository.getBillingDetail(billingId: billingId);

      if (response.status.isSuccess && response.data != null) {
        state = InvoiceDetailLoaded(data: response.data!);
      } else {
        state = InvoiceDetailFailure(response.status.message);
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to fetch billing details';
      state = InvoiceDetailFailure(errorMessage);
    } catch (e) {
      state = InvoiceDetailFailure('An unexpected error occurred');
    }
  }

  void reset() {
    state = InvoiceDetailInitial();
  }
}
