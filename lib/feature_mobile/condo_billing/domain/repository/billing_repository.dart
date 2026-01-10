import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/data/model/billing_model.dart';

abstract class BillingRepository {
  Future<BaseResponse<PendingBillingsData>> getPendingBillings({
    String? unitId,
  });
}
