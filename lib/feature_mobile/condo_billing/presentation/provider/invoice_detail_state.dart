import 'package:ams_mobile/feature_mobile/condo_billing/data/model/billing_model.dart';

sealed class InvoiceDetailState {}

class InvoiceDetailInitial extends InvoiceDetailState {}

class InvoiceDetailLoading extends InvoiceDetailState {}

class InvoiceDetailLoaded extends InvoiceDetailState {
  final BillingDetailData data;

  InvoiceDetailLoaded({required this.data});
}

class InvoiceDetailFailure extends InvoiceDetailState {
  final String errorMessage;

  InvoiceDetailFailure(this.errorMessage);
}
