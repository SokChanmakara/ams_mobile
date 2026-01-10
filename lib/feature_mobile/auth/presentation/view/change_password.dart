import 'package:flutter/material.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/core/utils/custom_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_event.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/change_password_entity.dart';
import 'package:ams_mobile/core/service/navigation_service.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _hasMinLength = false;
  bool _hasSpecialChar = false;
  String? _currentPasswordError;
  bool _hasFailedAttempt = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
    _currentPasswordController.addListener(_onCurrentPasswordChanged);
  }

  void _onCurrentPasswordChanged() {
    // Clear error and re-enable button when user modifies current password
    if (_hasFailedAttempt && _currentPasswordError != null) {
      setState(() {
        _currentPasswordError = null;
        _hasFailedAttempt = false;
      });
    }
  }

  void _validatePassword() {
    final password = _newPasswordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  void _handleResetPassword() {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    if (newPassword != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }

    if (!_hasMinLength || !_hasSpecialChar) {
      _showError('Please ensure all password requirements are met');
      return;
    }

    // Create change password entity and trigger event
    final changePasswordEntity = ChangePasswordEntity(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    ref
        .read(authNotifierProvider.notifier)
        .handleEvent(
          ChangePasswordEvent(changePasswordEntity: changePasswordEntity),
        );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.removeListener(_onCurrentPasswordChanged);
    _newPasswordController.removeListener(_validatePassword);
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is ChangePasswordSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'Password changed successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        // Trigger logout to clear session/token
        ref
            .read(authNotifierProvider.notifier)
            .handleEvent(const LogoutEvent());
      } else if (next is LogoutSuccess) {
        // After successful logout, navigate to login page
        NavigationService.navigateTo('/login');
      } else if (next is ChangePasswordFailure) {
        setState(() {
          // Check if error is related to incorrect current password
          if (next.errorMessage.toLowerCase().contains('current password') ||
              next.errorMessage.toLowerCase().contains('incorrect') ||
              next.errorMessage.toLowerCase().contains('wrong password')) {
            _currentPasswordError = next.errorMessage;
            _hasFailedAttempt = true;
          } else {
            _currentPasswordError = null;
            _hasFailedAttempt = false;
            // Show other errors in snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(next.errorMessage),
                backgroundColor: AppColors.error,
              ),
            );
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
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

                        // Current Password Field
                        CustomTextField(
                          label: 'Current Password',
                          hint: 'Enter current password',
                          icon: Icons.lock_outline,
                          controller: _currentPasswordController,
                          isPassword: true,
                          textInputAction: TextInputAction.next,
                          errorText: _currentPasswordError,
                        ),

                        const SizedBox(height: 24),

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
                          text: 'Change Password',
                          onPressed:
                              (authState is AuthLoading || _hasFailedAttempt)
                              ? null
                              : _handleResetPassword,
                          variant: ButtonVariant.primary,
                          size: ButtonSize.medium,
                          isLoading: authState is AuthLoading,
                          fullWidth: true,
                        ),

                        // Show helper text when button is disabled due to failed attempt
                        if (_hasFailedAttempt && _currentPasswordError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              'Please correct your current password to continue',
                              style: AppTextStyles.bodySmall(
                                color: AppColors.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
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
