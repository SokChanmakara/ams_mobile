import 'package:ams_mobile/feature_mobile/auth/presentation/view/reset_password.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_event.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Verification',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: AppTextStyles.getTextTheme(),
        scaffoldBackgroundColor: AppColors.backgroundLight,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        textTheme: AppTextStyles.getTextTheme(color: AppColors.textPrimaryDark),
        scaffoldBackgroundColor: AppColors.backgroundDark,
      ),
      themeMode: ThemeMode.system,
      home: const OTPVerificationScreen(email: ''),
    );
  }
}

class OTPVerificationScreen extends ConsumerStatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  ConsumerState<OTPVerificationScreen> createState() =>
      _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends ConsumerState<OTPVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  int _remainingSeconds = 45;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 45;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _onVerify() {
    String otp = _pinController.text;
    if (otp.length == 6) {
      // Trigger verify OTP event
      ref
          .read(authNotifierProvider.notifier)
          .handleEvent(VerifyOtpEvent(email: widget.email, otp: otp));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 6 digits'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _onResend() {
    if (_canResend) {
      _startTimer();
      // Trigger forgot password event again to resend code
      ref
          .read(authNotifierProvider.notifier)
          .handleEvent(ForgotPasswordEvent(email: widget.email));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is VerifyOtpSuccess) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'OTP verified successfully'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to change password page and reset the auth state
        Future.delayed(const Duration(milliseconds: 500), () {
          ref
              .read(authNotifierProvider.notifier)
              .handleEvent(const ResetAuthEvent());
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ResetPasswordScreen(),
            ),
          );
        });
      } else if (next is VerifyOtpFailure) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
        // Reset the auth state after showing the message
        Future.delayed(const Duration(milliseconds: 500), () {
          ref
              .read(authNotifierProvider.notifier)
              .handleEvent(const ResetAuthEvent());
        });
      } else if (next is ForgotPasswordSuccess) {
        // Show success message for resend
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'Code resent to your email'),
            backgroundColor: Colors.green,
          ),
        );
        // Reset the auth state after showing the message
        Future.delayed(const Duration(milliseconds: 500), () {
          ref
              .read(authNotifierProvider.notifier)
              .handleEvent(const ResetAuthEvent());
        });
      } else if (next is ForgotPasswordFailure) {
        // Show error message for resend
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
        // Reset the auth state after showing the message
        Future.delayed(const Duration(milliseconds: 500), () {
          ref
              .read(authNotifierProvider.notifier)
              .handleEvent(const ResetAuthEvent());
        });
      }
    });

    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background(context),
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new),
                      iconSize: 24.sp,
                      style: IconButton.styleFrom(
                        foregroundColor: AppColors.textPrimary(context),
                      ),
                    ),
                    SizedBox(width: 48.w),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),

                      // Hero Icon
                      Container(
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowMedium,
                              blurRadius: 12.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.mark_email_unread,
                          size: 64.sp,
                          color: AppColors.primary,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Title
                      Text(
                        'Verification',
                        style: AppTextStyles.displaySmall(
                          color: AppColors.textPrimary(context),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Subtitle
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppTextStyles.bodyLarge(
                            color: AppColors.textSecondary(context),
                          ),
                          children: [
                            const TextSpan(
                              text: 'Enter the 6-digit code sent to\n',
                            ),
                            TextSpan(
                              text: widget.email,
                              style: AppTextStyles.bodyLarge(
                                color: AppColors.textPrimary(context),
                                fontWeight: AppTextStyles.semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // OTP Input using Pinput
                      Pinput(
                        controller: _pinController,
                        focusNode: _pinFocusNode,
                        length: 6,
                        defaultPinTheme: PinTheme(
                          width: 52.w,
                          height: 64.h,
                          textStyle: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary(context),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface(context),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.border(
                                context,
                              ).withValues(alpha: 0.3),
                              width: 1.5.w,
                            ),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 52.w,
                          height: 64.h,
                          textStyle: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2.5.w,
                            ),
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          width: 52.w,
                          height: 64.h,
                          textStyle: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              width: 1.5.w,
                            ),
                          ),
                        ),
                        onCompleted: (pin) {
                          // Auto-verify when all digits are entered
                          _onVerify();
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        cursor: Container(
                          height: 28.h,
                          width: 2.w,
                          color: AppColors.primary,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // Timer & Resend
                      Column(
                        children: [
                          Text(
                            'Resend code in ${_formatTime(_remainingSeconds)}',
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.textTertiary(context),
                              fontWeight: AppTextStyles.medium,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextButton(
                            onPressed: _canResend ? _onResend : null,
                            child: Text(
                              'Resend Code',
                              style: AppTextStyles.bodyMedium(
                                color: _canResend
                                    ? AppColors.primary
                                    : AppColors.primary.withValues(alpha: 0.5),
                                fontWeight: AppTextStyles.semiBold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),

                      // Verify Button using CustomButton
                      CustomButton(
                        text: 'Verify',
                        onPressed: isLoading ? null : _onVerify,
                        size: ButtonSize.large,
                        borderRadius: 16.r,
                        isLoading: isLoading,
                      ),

                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

// Remove custom OTP input field and numeric keypad classes as they are no longer needed
/*
class _OTPInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;

  const _OTPInputField({
    required this.controller,
    required this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = controller.text.isNotEmpty;

    return SizedBox(
      width: 52.w,
      height: 64.h,
      child: Focus(
        onFocusChange: (hasFocus) {
          // Trigger rebuild when focus changes
          if (hasFocus) {
            (context as Element).markNeedsBuild();
          }
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
            color: hasValue
                ? AppColors.primary
                : AppColors.textPrimary(context),
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
          readOnly: true, // Make read-only to use custom keypad
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: hasValue
                ? AppColors.primary.withValues(alpha: 0.05)
                : AppColors.surface(context),
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: hasValue
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : AppColors.border(context).withValues(alpha: 0.3),
                width: 1.5.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primary, width: 2.5.w),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.border(context).withValues(alpha: 0.3),
                width: 1.5.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NumericKeypad extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback onBackspace;

  const _NumericKeypad({
    required this.onNumberPressed,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.backgroundDark.withValues(alpha: 0.9)
            : const Color(0xFFF1F5F9).withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: AppColors.border(context).withValues(alpha: 0.5),
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row 1
            _buildKeyRow(context, [
              _KeyData('1', ''),
              _KeyData('2', 'ABC'),
              _KeyData('3', 'DEF'),
            ]),
            SizedBox(height: 8.h),

            // Row 2
            _buildKeyRow(context, [
              _KeyData('4', 'GHI'),
              _KeyData('5', 'JKL'),
              _KeyData('6', 'MNO'),
            ]),
            SizedBox(height: 8.h),

            // Row 3
            _buildKeyRow(context, [
              _KeyData('7', 'PQRS'),
              _KeyData('8', 'TUV'),
              _KeyData('9', 'WXYZ'),
            ]),
            SizedBox(height: 8.h),

            // Row 4
            Row(
              children: [
                Expanded(child: Container()), // Empty space
                Expanded(child: _buildKey(context, _KeyData('0', ''), false)),
                Expanded(
                  child: _buildKey(context, _KeyData('backspace', ''), true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyRow(BuildContext context, List<_KeyData> keys) {
    return Row(
      children: keys
          .map((key) => Expanded(child: _buildKey(context, key, false)))
          .toList(),
    );
  }

  Widget _buildKey(BuildContext context, _KeyData keyData, bool isBackspace) {
    return InkWell(
      onTap: () {
        if (isBackspace) {
          onBackspace();
        } else {
          onNumberPressed(keyData.number);
        }
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 48.h,
        alignment: Alignment.center,
        child: isBackspace
            ? Icon(
                Icons.backspace_outlined,
                color: AppColors.textPrimary(context),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    keyData.number,
                    style: AppTextStyles.titleLarge(
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                  if (keyData.letters.isNotEmpty)
                    Text(
                      keyData.letters,
                      style: AppTextStyles.labelSmall(
                        color: AppColors.textTertiary(context),
                        fontWeight: AppTextStyles.bold,
                      ).copyWith(letterSpacing: 2),
                    ),
                ],
              ),
      ),
    );
  }
}

class _KeyData {
  final String number;
  final String letters;

  _KeyData(this.number, this.letters);
}
*/
