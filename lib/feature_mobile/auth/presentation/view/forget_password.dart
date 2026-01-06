import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/core/utils/custom_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle password reset logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Reset link sent to your email'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background(context),
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
                                border: Border.all(
                                  color: AppColors.surface(context),
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDEX3KHtWiCRShg4vM050r26m_gnf8alFF5zEsuhv37saN7qGAJxbHS1YQm9BjSHe3cdfsUn6zFadm7yCIXUzL1qXTrAFHij-_n8rtCWF14CGV-KJn3k638i679TmbATZsR7mDxKZSHv9elw_0yYTiDMfOIKl4hJQLCUSl_qa_Ah3G9jUCV4YQxYpIY0CyxYu6_46AuACJfP4SmF68ggCkjiucfz1ZbgCxyf5hXhL4oKSmNXuKXUdmDMjmhb_49QbAfu15pr4g0egZg',
                                  ),
                                  fit: BoxFit.cover,
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
                                  onPressed: _handleSubmit,
                                  icon: Icons.send,
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
