import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/core/utils/custom_textfield.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_event.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/view/otp_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Trigger forgot password event
      ref
          .read(authNotifierProvider.notifier)
          .handleEvent(
            ForgotPasswordEvent(email: _emailController.text.trim()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is ForgotPasswordSuccess) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'Reset link sent to your email'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to OTP verification page and reset the auth state
        Future.delayed(const Duration(milliseconds: 500), () {
          ref
              .read(authNotifierProvider.notifier)
              .handleEvent(const ResetAuthEvent());
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  OTPVerificationScreen(email: _emailController.text.trim()),
            ),
          );
        });
      } else if (next is ForgotPasswordFailure) {
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
      }
    });

    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top App Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => NavigationService.goBack(),
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 24,
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.surface(context),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 448),
                      child: Column(
                        children: [
                          // Hero Image
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,
                                border: Border.all(
                                  color: AppColors.neutral200,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.shadowMedium,
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.email,
                                  size: 72,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          // Headline
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.headlineLarge(
                                color: AppColors.textPrimary(context),
                                fontWeight: AppTextStyles.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // Body Text
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                              bottom: 32.0,
                            ),
                            child: Text(
                              'Don\'t worry, it happens. Please enter the email address linked to your condominium account to reset your password.',
                              style: AppTextStyles.bodyLarge(
                                color: AppColors.textSecondary(context),
                                fontWeight: AppTextStyles.medium,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // Form
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email Input Field
                                CustomTextField(
                                  label: 'Email Address',
                                  hint: 'resident@condo.com',
                                  icon: Icons.mail_outline,
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    ).hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Submit Button
                                CustomButton(
                                  text: 'Send Reset Link',
                                  onPressed: isLoading ? null : _handleSubmit,
                                  icon: Icons.send,
                                  isLoading: isLoading,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Footer
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Remember your password?',
                                    style: AppTextStyles.bodyMedium(
                                      color: AppColors.textSecondary(context),
                                    ),
                                  ),
                                  CustomButton(
                                    text: 'Log in',
                                    variant: ButtonVariant.text,
                                    size: ButtonSize.small,
                                    fullWidth: false,
                                    onPressed: () {
                                      NavigationService.goBack();
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 1,
                                color: AppColors.border(context),
                              ),

                              const SizedBox(height: 16),

                              CustomButton(
                                text: 'Contact Property Manager',
                                variant: ButtonVariant.text,
                                size: ButtonSize.small,
                                icon: Icons.help_outline,
                                iconAtEnd: false,
                                fullWidth: false,
                                onPressed: () {
                                  // Contact property manager
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
