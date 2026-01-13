import 'package:flutter/material.dart';

/// Payment Status Step Model
class PaymentStatusStep {
  final String title;
  final String? subtitle;
  final IconData icon;
  final StepStatus status;
  final bool hasAction;
  final String? actionLabel;

  const PaymentStatusStep({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.status,
    this.hasAction = false,
    this.actionLabel,
  });
}

/// Step Status Enum
enum StepStatus { completed, current, inactive }
