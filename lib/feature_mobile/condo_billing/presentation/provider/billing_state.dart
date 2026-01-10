import 'package:ams_mobile/feature_mobile/condo_billing/data/model/billing_model.dart';

sealed class BillingState {}

class BillingInitial extends BillingState {}

class BillingLoading extends BillingState {}

class BillingLoaded extends BillingState {
  final PendingBillingsData data;

  BillingLoaded({required this.data});
}

class BillingFailure extends BillingState {
  final String errorMessage;

  BillingFailure(this.errorMessage);
}
