import 'dart:io';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_page/payment_bank_section.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_page/payment_complete_button.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_page/payment_Detail_card.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_page/payment_header.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_page/payment_qr_section.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_page/payment_receipt_section.dart';
import 'package:ams_mobile/feature_mobile/condo_billing/presentation/widgets/payment_page/payment_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
// import 'package:qr_flutter/qr_flutter.dart'; // Add this to pubspec.yaml if needed
// import 'package:path_provider/path_provider.dart'; // Add this to pubspec.yaml if needed
// import 'package:screenshot/screenshot.dart'; // Add this to pubspec.yaml if needed
// import 'package:url_launcher/url_launcher.dart'; // Add this to pubspec.yaml if needed

class PaymentPage extends StatefulWidget {
  final String invoiceNumber;
  final String amount;
  final String description;

  const PaymentPage({
    super.key,
    required this.invoiceNumber,
    required this.amount,
    required this.description,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  File? _uploadedReceipt;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  // QR Code data - replace with actual payment gateway data
  String get qrCodeData => 'PAYMENT:${widget.invoiceNumber}:${widget.amount}';

  Future<void> _pickReceipt() async {
    try {
      setState(() => _isUploading = true);

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _uploadedReceipt = File(image.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Receipt uploaded successfully'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to upload receipt'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  Future<void> _downloadQRCode() async {
    // Implement QR code download using screenshot package
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('QR Code downloaded to gallery'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
    }
  }

  Future<void> _openBankApp() async {
    // Replace with actual bank app deep link
    // const bankUrl = 'https://bank.example.com/payment';

    // if (await canLaunchUrl(Uri.parse(bankUrl))) {
    //   await launchUrl(Uri.parse(bankUrl), mode: LaunchMode.externalApplication);
    // } else {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Opening bank portal...'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
    }
    // }
  }

  void _completePayment() {
    if (_uploadedReceipt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please upload payment receipt first'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      return;
    }

    // Process payment completion
    showDialog(
      context: context,
      builder: (context) => const PaymentSuccessDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            PaymentHeader(invoiceNumber: widget.invoiceNumber),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment Details Card
                    PaymentDetailCard(
                      description: widget.description,
                      amount: widget.amount,
                    ),
                    SizedBox(height: 24.h),

                    // QR Code Section
                    PaymentQrSection(
                      invoiceNumber: widget.invoiceNumber,
                      onDownloadQRCode: _downloadQRCode,
                    ),
                    SizedBox(height: 24.h),

                    // Bank Payment Option
                    PaymentBankSection(
                      invoiceNumber: widget.invoiceNumber,
                      onOpenBankApp: _openBankApp,
                    ),
                    SizedBox(height: 24.h),

                    // Upload Receipt Section
                    PaymentReceiptSection(
                      uploadedReceipt: _uploadedReceipt,
                      isUploading: _isUploading,
                      onPickReceipt: _pickReceipt,
                      onRemoveReceipt: () =>
                          setState(() => _uploadedReceipt = null),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),

            // Complete Button
            PaymentCompleteButton(
              hasReceipt: _uploadedReceipt != null,
              onComplete: _completePayment,
            ),
          ],
        ),
      ),
    );
  }
}
