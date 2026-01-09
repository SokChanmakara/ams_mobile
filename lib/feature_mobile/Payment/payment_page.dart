import 'dart:io';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:qr_flutter/qr_flutter.dart'; // Add this to pubspec.yaml
// import 'package:path_provider/path_provider.dart'; // Add this to pubspec.yaml
// import 'package:screenshot/screenshot.dart'; // Add this to pubspec.yaml
// import 'package:url_launcher/url_launcher.dart'; // Add this to pubspec.yaml

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

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Receipt uploaded successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload receipt'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  Future<void> _downloadQRCode() async {
    // Implement QR code download using screenshot package
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('QR Code downloaded to gallery'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  Future<void> _openBankApp() async {
    // Replace with actual bank app deep link
    const bankUrl = 'https://bank.example.com/payment';

    // if (await canLaunchUrl(Uri.parse(bankUrl))) {
    //   await launchUrl(Uri.parse(bankUrl), mode: LaunchMode.externalApplication);
    // } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening bank portal...'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    // }
  }

  void _completePayment() {
    if (_uploadedReceipt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload payment receipt first'),
          backgroundColor: Colors.orange,
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
      builder: (context) => _buildSuccessDialog(),
    );
  }

  Widget _buildSuccessDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Container(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                size: 48.sp,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Payment Submitted!',
              style: AppTextStyles.headlineSmall(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Your payment is being processed. You will receive a confirmation once verified.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondary(context),
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Return to billing page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Done',
                  style: AppTextStyles.bodyLarge(
                    color: Colors.white,
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
            _buildHeader(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment Details Card
                    _buildPaymentDetailsCard(),
                    SizedBox(height: 24.h),

                    // QR Code Section
                    _buildQRCodeSection(),
                    SizedBox(height: 24.h),

                    // Bank Payment Option
                    _buildBankPaymentSection(),
                    SizedBox(height: 24.h),

                    // Upload Receipt Section
                    _buildUploadReceiptSection(),
                    SizedBox(height: 32.h),

                    // Instructions
                    _buildInstructions(),
                  ],
                ),
              ),
            ),

            // Complete Button
            _buildCompleteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        border: Border(
          bottom: BorderSide(
            color: AppColors.border(context).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.isDark(context)
                    ? AppColors.surfaceDark
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18.sp,
                color: AppColors.textPrimary(context),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment',
                  style: AppTextStyles.headlineSmall(
                    color: AppColors.textPrimary(context),
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
                Text(
                  widget.invoiceNumber,
                  style: AppTextStyles.caption(
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount to Pay',
                style: AppTextStyles.bodyMedium(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: AppTextStyles.medium,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Pending',
                  style: AppTextStyles.labelSmall(
                    color: Colors.white,
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            widget.amount,
            style: AppTextStyles.displayMedium(
              color: Colors.white,
              fontWeight: AppTextStyles.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.description,
                    style: AppTextStyles.bodyMedium(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.border(context).withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Section Title
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.qr_code_2_rounded,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scan to Pay',
                      style: AppTextStyles.titleMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    Text(
                      'Use your banking app to scan',
                      style: AppTextStyles.caption(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // QR Code Display
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.border(context).withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                // Placeholder for QR Code
                // Replace with: QrImageView(data: qrCodeData, size: 200.w)
                Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.qr_code_2,
                    size: 120.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  widget.invoiceNumber,
                  style: AppTextStyles.labelLarge(
                    color: AppColors.textSecondary(context),
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Download Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _downloadQRCode,
              icon: Icon(Icons.download_rounded, size: 20.sp),
              label: Text('Download QR Code'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary, width: 1.5),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankPaymentSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.border(context).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay via Bank Transfer',
                      style: AppTextStyles.titleMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    Text(
                      'Manual bank transfer option',
                      style: AppTextStyles.caption(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Bank Details
          _buildBankDetailRow('Account Name', 'Condo Management Ltd'),
          SizedBox(height: 12.h),
          _buildBankDetailRow('Account Number', '1234-5678-9012'),
          SizedBox(height: 12.h),
          _buildBankDetailRow('Bank', 'Example Bank'),
          SizedBox(height: 12.h),
          _buildBankDetailRow('Reference', widget.invoiceNumber),
          SizedBox(height: 20.h),

          // Open Bank Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _openBankApp,
              icon: Icon(Icons.open_in_new, size: 20.sp),
              label: Text('Open Banking App'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium(
            color: AppColors.textSecondary(context),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium(
            color: AppColors.textPrimary(context),
            fontWeight: AppTextStyles.semiBold,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadReceiptSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: _uploadedReceipt != null
              ? Colors.green.withValues(alpha: 0.5)
              : AppColors.border(context).withValues(alpha: 0.3),
          width: _uploadedReceipt != null ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: _uploadedReceipt != null
                      ? Colors.green.withValues(alpha: 0.1)
                      : AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _uploadedReceipt != null
                      ? Icons.check_circle_outline
                      : Icons.upload_file_outlined,
                  color: _uploadedReceipt != null
                      ? Colors.green
                      : AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Receipt',
                      style: AppTextStyles.titleMedium(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    Text(
                      _uploadedReceipt != null
                          ? 'Receipt uploaded successfully'
                          : 'Upload proof of payment',
                      style: AppTextStyles.caption(
                        color: _uploadedReceipt != null
                            ? Colors.green
                            : AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Receipt Preview or Upload Button
          if (_uploadedReceipt != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.file(
                    _uploadedReceipt!,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () => setState(() => _uploadedReceipt = null),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            GestureDetector(
              onTap: _isUploading ? null : _pickReceipt,
              child: Container(
                height: 160.h,
                decoration: BoxDecoration(
                  color: AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.border(context).withValues(alpha: 0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isUploading)
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        )
                      else ...[
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 48.sp,
                          color: AppColors.textSecondary(context),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Tap to upload receipt',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.textSecondary(context),
                            fontWeight: AppTextStyles.medium,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'PNG, JPG or PDF',
                          style: AppTextStyles.caption(
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Payment Instructions',
                style: AppTextStyles.titleSmall(
                  color: AppColors.primary,
                  fontWeight: AppTextStyles.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInstructionItem('1', 'Scan QR code or open banking app'),
          _buildInstructionItem('2', 'Complete payment using reference number'),
          _buildInstructionItem('3', 'Upload payment receipt'),
          _buildInstructionItem('4', 'Click Complete to submit'),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: AppTextStyles.labelSmall(
                  color: Colors.white,
                  fontWeight: AppTextStyles.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium(
                color: AppColors.textPrimary(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        border: Border(
          top: BorderSide(
            color: AppColors.border(context).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _completePayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: _uploadedReceipt != null
                  ? AppColors.primary
                  : AppColors.textSecondary(context),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Complete Payment',
                  style: AppTextStyles.bodyLarge(
                    color: Colors.white,
                    fontWeight: AppTextStyles.bold,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.check_circle_outline, size: 22.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}