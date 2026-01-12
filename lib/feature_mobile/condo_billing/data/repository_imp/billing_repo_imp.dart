import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/data/model/billing_model.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/domain/repository/billing_repository.dart';

class BillingRepoImp extends BillingRepository {
  @override
  Future<BaseResponse<PendingBillingsData>> getPendingBillings({
    String? unitId,
  }) async {
    final queryParams = unitId != null ? {'unitId': unitId} : null;

    final response = await HttpService.instance.get(
      BaseUrl.pendingBillings,
      queryParameters: queryParams,
    );

    return BaseResponse<PendingBillingsData>.fromJson(
      response.data,
      (json) => PendingBillingsData.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<BaseResponse<BillingDetailData>> getBillingDetail({
    required String billingId,
  }) async {
    final response = await HttpService.instance.get(
      BaseUrl.billingDetails(billingId),
    );

    return BaseResponse<BillingDetailData>.fromJson(
      response.data,
      (json) => BillingDetailData.fromJson(json as Map<String, dynamic>),
    );
  }
}
