import 'package:ams_mobile/feature_mobile/home/data/model/unit_model.dart';
import 'package:flutter/material.dart';

class BillingSummary {
  final int count;
  final double totalOutstanding;

  BillingSummary({required this.count, required this.totalOutstanding});

  factory BillingSummary.fromJson(Map<String, dynamic> json) {
    return BillingSummary(
      count: json['count'] as int,
      totalOutstanding: (json['totalOutstanding'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'totalOutstanding': totalOutstanding};
  }
}

class BillingModel {
  final String id;
  final String clientId;
  final String unitId;
  final String userId;
  final String invoiceNumber;
  final String referenceNumber;
  final String accountType;
  final String billingType;
  final String status;
  final String settlementStatus;
  final String description;
  final String subtotalAmount;
  final String taxAmount;
  final String discountAmount;
  final String lateFeeAmount;
  final String totalAmount;
  final String paidAmount;
  final String balanceAmount;
  final String billingDate;
  final String dueDate;
  final String billingPeriodStart;
  final String billingPeriodEnd;
  final String? paymentMethod;
  final String? paymentReference;
  final String? paymentDate;
  final String? settlementDate;
  final String sentDate;
  final int reminderCount;
  final String? lastReminderDate;
  final String notes;
  final String? internalNotes;
  final String createdBy;
  final String approvedBy;
  final String approvedAt;
  final String createdAt;
  final String updatedAt;
  final UnitModel unit;
  final List<String> paymentAttachmentUrls;

  BillingModel({
    required this.id,
    required this.clientId,
    required this.unitId,
    required this.userId,
    required this.invoiceNumber,
    required this.referenceNumber,
    required this.accountType,
    required this.billingType,
    required this.status,
    required this.settlementStatus,
    required this.description,
    required this.subtotalAmount,
    required this.taxAmount,
    required this.discountAmount,
    required this.lateFeeAmount,
    required this.totalAmount,
    required this.paidAmount,
    required this.balanceAmount,
    required this.billingDate,
    required this.dueDate,
    required this.billingPeriodStart,
    required this.billingPeriodEnd,
    this.paymentMethod,
    this.paymentReference,
    this.paymentDate,
    this.settlementDate,
    required this.sentDate,
    required this.reminderCount,
    this.lastReminderDate,
    required this.notes,
    this.internalNotes,
    required this.createdBy,
    required this.approvedBy,
    required this.approvedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.unit,
    required this.paymentAttachmentUrls,
  });

  factory BillingModel.fromJson(Map<String, dynamic> json) {
    return BillingModel(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      unitId: json['unitId'] as String,
      userId: json['userId'] as String,
      invoiceNumber: json['invoiceNumber'] as String,
      referenceNumber: json['referenceNumber'] as String,
      accountType: json['accountType'] as String,
      billingType: json['billingType'] as String,
      status: json['status'] as String,
      settlementStatus: json['settlementStatus'] as String,
      description: json['description'] as String,
      subtotalAmount: json['subtotalAmount'] as String,
      taxAmount: json['taxAmount'] as String,
      discountAmount: json['discountAmount'] as String,
      lateFeeAmount: json['lateFeeAmount'] as String,
      totalAmount: json['totalAmount'] as String,
      paidAmount: json['paidAmount'] as String,
      balanceAmount: json['balanceAmount'] as String,
      billingDate: json['billingDate'] as String,
      dueDate: json['dueDate'] as String,
      billingPeriodStart: json['billingPeriodStart'] as String,
      billingPeriodEnd: json['billingPeriodEnd'] as String,
      paymentMethod: json['paymentMethod'] as String?,
      paymentReference: json['paymentReference'] as String?,
      paymentDate: json['paymentDate'] as String?,
      settlementDate: json['settlementDate'] as String?,
      sentDate: json['sentDate'] as String,
      reminderCount: json['reminderCount'] as int,
      lastReminderDate: json['lastReminderDate'] as String?,
      notes: json['notes'] as String,
      internalNotes: json['internalNotes'] as String?,
      createdBy: json['createdBy'] as String,
      approvedBy: json['approvedBy'] as String,
      approvedAt: json['approvedAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      unit: UnitModel.fromJson(json['unit'] as Map<String, dynamic>),
      paymentAttachmentUrls: (json['paymentAttachmentUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'unitId': unitId,
      'userId': userId,
      'invoiceNumber': invoiceNumber,
      'referenceNumber': referenceNumber,
      'accountType': accountType,
      'billingType': billingType,
      'status': status,
      'settlementStatus': settlementStatus,
      'description': description,
      'subtotalAmount': subtotalAmount,
      'taxAmount': taxAmount,
      'discountAmount': discountAmount,
      'lateFeeAmount': lateFeeAmount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'balanceAmount': balanceAmount,
      'billingDate': billingDate,
      'dueDate': dueDate,
      'billingPeriodStart': billingPeriodStart,
      'billingPeriodEnd': billingPeriodEnd,
      'paymentMethod': paymentMethod,
      'paymentReference': paymentReference,
      'paymentDate': paymentDate,
      'settlementDate': settlementDate,
      'sentDate': sentDate,
      'reminderCount': reminderCount,
      'lastReminderDate': lastReminderDate,
      'notes': notes,
      'internalNotes': internalNotes,
      'createdBy': createdBy,
      'approvedBy': approvedBy,
      'approvedAt': approvedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'unit': unit.toJson(),
      'paymentAttachmentUrls': paymentAttachmentUrls,
    };
  }

  // Helper method to format amount
  String get formattedTotalAmount {
    final amount = double.tryParse(totalAmount) ?? 0.0;
    return '\$${amount.toStringAsFixed(2)}';
  }

  String get formattedBalanceAmount {
    final amount = double.tryParse(balanceAmount) ?? 0.0;
    return '\$${amount.toStringAsFixed(2)}';
  }

  // Helper method to get billing type icon
  IconData get billingTypeIcon {
    switch (billingType.toLowerCase()) {
      case 'service_charge':
        return Icons.receipt_long_outlined;
      case 'utilities':
        return Icons.water_drop_outlined;
      case 'sinking_fund':
        return Icons.security_outlined;
      default:
        return Icons.receipt_outlined;
    }
  }

  // Helper method to format billing type display name
  String get billingTypeDisplayName {
    switch (billingType.toLowerCase()) {
      case 'service_charge':
        return 'Service Charge';
      case 'utilities':
        return 'Utilities';
      case 'sinking_fund':
        return 'Sinking Fund';
      default:
        return billingType;
    }
  }
}

class PendingBillingsData {
  final List<BillingModel> billings;
  final BillingSummary summary;

  PendingBillingsData({required this.billings, required this.summary});

  factory PendingBillingsData.fromJson(Map<String, dynamic> json) {
    return PendingBillingsData(
      billings: (json['billings'] as List<dynamic>)
          .map((e) => BillingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: BillingSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'billings': billings.map((e) => e.toJson()).toList(),
      'summary': summary.toJson(),
    };
  }

  // Helper to format total outstanding
  String get formattedTotalOutstanding {
    return '\$${summary.totalOutstanding.toStringAsFixed(2)}';
  }
}
