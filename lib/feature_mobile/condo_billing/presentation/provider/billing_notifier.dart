import 'package:ams_mobile/feature_mobile/condo_billing/domain/repository/billing_repository.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_provider.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/provider/billing_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingNotifier extends Notifier<BillingState> {
  late final BillingRepository _repository;

  @override
  BillingState build() {
    _repository = ref.read(billingRepositoryProvider);
    return BillingInitial();
  }

  Future<void> fetchPendingBillings({String? unitId}) async {
    state = BillingLoading();
    try {
      final response = await _repository.getPendingBillings(unitId: unitId);

      if (response.status.isSuccess && response.data != null) {
        state = BillingLoaded(data: response.data!);
      } else {
        state = BillingFailure(response.status.message);
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to fetch pending billings';
      state = BillingFailure(errorMessage);
    } catch (e) {
      state = BillingFailure('An unexpected error occurred');
    }
  }

  void reset() {
    state = BillingInitial();
  }
}
