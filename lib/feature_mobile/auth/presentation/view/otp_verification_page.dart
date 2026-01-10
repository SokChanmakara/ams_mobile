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
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

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

  void _onNumberPressed(String number) {
    // Find the first empty field or the focused field
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.isEmpty) {
        setState(() {
          _controllers[i].text = number;
        });
        if (i < _controllers.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
        break;
      }
    }
  }

  void _onBackspace() {
    // Find the last filled field and clear it
    for (int i = _controllers.length - 1; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        setState(() {
          _controllers[i].text = '';
        });
        _focusNodes[i].requestFocus();
        break;
      }
    }
  }

  void _onVerify() {
    String otp = _controllers.map((c) => c.text).join();
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
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
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

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new),
                    iconSize: 24,
                    style: IconButton.styleFrom(
                      foregroundColor: AppColors.textPrimary(context),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Hero Icon
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowMedium,
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.mark_email_unread,
                        size: 64,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Title
                    Text(
                      'Verification',
                      style: AppTextStyles.displaySmall(
                        color: AppColors.textPrimary(context),
                      ),
                    ),

                    const SizedBox(height: 12),

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

                    const SizedBox(height: 40),

                    // OTP Input Fields - Updated to 6 digits
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: _OTPInputField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                _focusNodes[index + 1].requestFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

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
                        const SizedBox(height: 8),
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

                    const SizedBox(height: 32),

                    // Verify Button using CustomButton
                    CustomButton(
                      text: 'Verify',
                      onPressed: isLoading ? null : _onVerify,
                      size: ButtonSize.large,
                      borderRadius: 16,
                      isLoading: isLoading,
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Numeric Keypad
            _NumericKeypad(
              onNumberPressed: _onNumberPressed,
              onBackspace: _onBackspace,
            ),
          ],
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
      width: 52,
      height: 64,
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
            fontSize: 28,
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
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasValue
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : AppColors.border(context).withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.border(context).withValues(alpha: 0.3),
                width: 1.5,
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
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
            const SizedBox(height: 8),

            // Row 2
            _buildKeyRow(context, [
              _KeyData('4', 'GHI'),
              _KeyData('5', 'JKL'),
              _KeyData('6', 'MNO'),
            ]),
            const SizedBox(height: 8),

            // Row 3
            _buildKeyRow(context, [
              _KeyData('7', 'PQRS'),
              _KeyData('8', 'TUV'),
              _KeyData('9', 'WXYZ'),
            ]),
            const SizedBox(height: 8),

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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
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
