import 'package:flutter/material.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/reset_password_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_event.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Password requirements
  bool _hasMinLength = false;
  bool _hasNumber = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _newPasswordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasNumber = password.contains(RegExp(r'[0-9]'));
    });
  }

  int _getPasswordStrength() {
    final password = _newPasswordController.text;
    int strength = 0;

    // Only check for 2 requirements
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;

    return strength;
  }

  void _handleResetPassword() async {
    if (_newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }

    if (!_hasMinLength || !_hasNumber) {
      _showError('Please meet all password requirements');
      return;
    }

    // Get reset password token from storage
    final token = StorageService.getResetPasswordToken();
    if (token == null || token.isEmpty) {
      _showError('Reset session expired. Please try again.');
      return;
    }

    // Create reset password entity
    final resetPasswordEntity = ResetPasswordEntity(
      token: token,
      newPassword: _newPasswordController.text,
      confirmNewPassword: _confirmPasswordController.text,
    );

    // Trigger reset password event
    ref
        .read(authNotifierProvider.notifier)
        .handleEvent(
          ResetPasswordWithTokenEvent(resetPasswordEntity: resetPasswordEntity),
        );
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
    final authState = ref.watch(authNotifierProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is ResetPasswordSuccess) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'Password reset successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        // Navigate to login page and reset the auth state
        Future.delayed(const Duration(milliseconds: 500), () {
          ref
              .read(authNotifierProvider.notifier)
              .handleEvent(const ResetAuthEvent());
          NavigationService.navigateTo('/login');
        });
      } else if (next is ResetPasswordFailure) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: AppColors.error,
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

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 390),
            child: Column(
              children: [
                // Status Bar Spacing
                const SizedBox(height: 12),

                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // Back Button
                      Material(
                        color: Colors.transparent,
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
                              size: 24,
                            ),
                          ),
                        ),
                      ),

                      // Title
                      Expanded(
                        child: Text(
                          'Reset Password',
                          style: AppTextStyles.titleLarge(
                            color: AppColors.textPrimary(context),
                            fontWeight: AppTextStyles.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Spacer for alignment
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                    child: Column(
                      children: [
                        // Hero Icon
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_reset,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Title and Description
                        Text(
                          'Create new password',
                          style: AppTextStyles.headlineSmall(
                            color: AppColors.textPrimary(context),
                            fontWeight: AppTextStyles.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Please create a secure password including numbers and symbols for your unit account.',
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.textSecondary(context),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // New Password Field
                        _PasswordField(
                          label: 'New Password',
                          hint: 'Enter new password',
                          icon: Icons.lock_outline,
                          controller: _newPasswordController,
                          isVisible: _isNewPasswordVisible,
                          onVisibilityToggle: () {
                            setState(() {
                              _isNewPasswordVisible = !_isNewPasswordVisible;
                            });
                          },
                        ),

                        const SizedBox(height: 24),

                        // Confirm Password Field
                        _PasswordField(
                          label: 'Confirm New Password',
                          hint: 'Re-enter new password',
                          icon: Icons.lock_clock_outlined,
                          controller: _confirmPasswordController,
                          isVisible: _isConfirmPasswordVisible,
                          onVisibilityToggle: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),

                        const SizedBox(height: 24),

                        // Password Strength Indicator
                        _PasswordStrengthIndicator(
                          strength: _getPasswordStrength(),
                          hasMinLength: _hasMinLength,
                          hasNumber: _hasNumber,
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Button
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                  color: AppColors.background(context),
                  child: CustomButton(
                    text: 'Reset Password',
                    onPressed: authState is AuthLoading
                        ? null
                        : _handleResetPassword,
                    variant: ButtonVariant.primary,
                    size: ButtonSize.medium,
                    isLoading: authState is AuthLoading,
                    fullWidth: true,
                    icon: Icons.arrow_forward,
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

// Custom Password Field Widget
class _PasswordField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback onVisibilityToggle;

  const _PasswordField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.isVisible,
    required this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(
              color: AppColors.textPrimary(context),
              fontWeight: AppTextStyles.medium,
            ),
          ),
        ),

        // Input Field
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.isDark(context)
                ? AppColors.white.withValues(alpha: 0.05)
                : AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.isDark(context)
                  ? AppColors.white.withValues(alpha: 0.1)
                  : AppColors.border(context),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: !isVisible,
            style: AppTextStyles.bodyLarge(
              color: AppColors.textPrimary(context),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.bodyLarge(
                color: AppColors.textSecondary(context).withValues(alpha: 0.5),
              ),
              prefixIcon: Icon(
                icon,
                color: AppColors.textSecondary(context),
                size: 20,
              ),
              suffixIcon: IconButton(
                onPressed: onVisibilityToggle,
                icon: Icon(
                  isVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary(context),
                  size: 22,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Password Strength Indicator Widget
class _PasswordStrengthIndicator extends StatelessWidget {
  final int strength; // 0-2 (changed from 0-4)
  final bool hasMinLength;
  final bool hasNumber;

  const _PasswordStrengthIndicator({
    required this.strength,
    required this.hasMinLength,
    required this.hasNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'PASSWORD STRENGTH',
            style: AppTextStyles.labelSmall(
              color: AppColors.textSecondary(context),
              fontWeight: AppTextStyles.medium,
            ).copyWith(letterSpacing: 1.2),
          ),
        ),

        // Strength Bars - Changed to 2 bars
        Row(
          children: List.generate(2, (index) {
            final isActive = index < strength;
            return Expanded(
              child: Container(
                height: 6,
                margin: EdgeInsets.only(right: index < 1 ? 8 : 0),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 12),

        // Requirements List
        Column(
          children: [
            _RequirementItem(
              text: 'Must be at least 8 characters',
              isMet: hasMinLength,
            ),
            const SizedBox(height: 8),
            _RequirementItem(
              text: 'Include at least one number',
              isMet: hasNumber,
            ),
          ],
        ),
      ],
    );
  }
}

// Requirement Item Widget
class _RequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const _RequirementItem({required this.text, required this.isMet});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 16,
          color: isMet
              ? AppColors.success
              : (AppColors.isDark(context)
                    ? AppColors.textDisabled(context)
                    : const Color(0xFFD1D5DB)),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyles.bodyMedium(
            color: AppColors.textSecondary(context),
          ),
        ),
      ],
    );
  }
}
