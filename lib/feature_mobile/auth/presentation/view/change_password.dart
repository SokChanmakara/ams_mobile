import 'package:flutter/material.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/core/utils/custom_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _hasMinLength = false;
  bool _hasSpecialChar = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _newPasswordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  void _handleResetPassword() {
    if (_newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }

    if (!_hasMinLength || !_hasSpecialChar) {
      _showError('Please ensure all password requirements are met');
      return;
    }

    // Simulate API call
    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Password reset successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      // Navigate back or to login screen
      Navigator.of(context).pop();
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: AppColors.surface(context),
                        borderRadius: BorderRadius.circular(9999),
                        elevation: 2,
                        shadowColor: AppColors.shadowLight,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          borderRadius: BorderRadius.circular(9999),
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.textPrimary(context),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Headline
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Set new password',
                              style: AppTextStyles.headlineMedium(
                                color: AppColors.textPrimary(context),
                                fontWeight: AppTextStyles.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Your new password must be different from previously used passwords.',
                              style: AppTextStyles.bodyLarge(
                                color: AppColors.textSecondary(context),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // New Password Field
                        CustomTextField(
                          label: 'New Password',
                          hint: 'Min. 8 characters',
                          icon: Icons.lock_outline,
                          controller: _newPasswordController,
                          isPassword: true,
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(height: 24),

                        // Confirm Password Field
                        CustomTextField(
                          label: 'Confirm Password',
                          hint: 'Re-enter password',
                          icon: Icons.lock_outline,
                          controller: _confirmPasswordController,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _handleResetPassword(),
                        ),

                        const SizedBox(height: 24),

                        // Requirements Checklist
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PASSWORD REQUIREMENTS:',
                                style: AppTextStyles.labelSmall(
                                  color: AppColors.textTertiary(context),
                                  fontWeight: AppTextStyles.semiBold,
                                ).copyWith(letterSpacing: 1.2),
                              ),
                              const SizedBox(height: 12),
                              _RequirementItem(
                                text: 'Minimum 8 characters',
                                isMet: _hasMinLength,
                              ),
                              const SizedBox(height: 8),
                              _RequirementItem(
                                text: 'At least one special character',
                                isMet: _hasSpecialChar,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Reset Password Button
                        CustomButton(
                          text: 'Reset Password',
                          onPressed: _isLoading ? null : _handleResetPassword,
                          variant: ButtonVariant.primary,
                          size: ButtonSize.medium,
                          isLoading: _isLoading,
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const _RequirementItem({required this.text, required this.isMet});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isMet
                ? (AppColors.isDark(context)
                      ? AppColors.successDark.withValues(alpha: 0.3)
                      : AppColors.successLight)
                : (AppColors.isDark(context)
                      ? AppColors.borderDark
                      : AppColors.shimmerBase(context)),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isMet ? Icons.check : Icons.close,
            size: 14,
            color: isMet
                ? (AppColors.isDark(context)
                      ? AppColors.success.withValues(alpha: 0.8)
                      : AppColors.success)
                : AppColors.textDisabled(context),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTextStyles.bodyMedium(
            color: isMet
                ? AppColors.textPrimary(context)
                : AppColors.textDisabled(context),
            fontWeight: AppTextStyles.medium,
          ),
        ),
      ],
    );
  }
}
