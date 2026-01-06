import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_event.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:ams_mobile/core/utils/custom_textfield.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final username = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    final loginEntity = LoginEntity(username: username, password: password);

    ref
        .read(authNotifierProvider.notifier)
        .handleEvent(LoginEvent(loginEntity: loginEntity));
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is LoginSuccess) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(next.message ?? 'Login successful!'),
        //     backgroundColor: Colors.green,
        //   ),
        // );
        NavigationService.navigateTo('/home');
      } else if (next is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background(context),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Section
                    Column(
                      children: [
                        // App Logo/Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.apartment,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Title
                        Text(
                          'Welcome Back',
                          style: AppTextStyles.h1(
                            color: AppColors.textPrimary(context),
                            fontWeight: AppTextStyles.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subtitle
                        Text(
                          'Please sign in to access your unit and manage your property services.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyLarge(
                            color: AppColors.textSecondary(context),
                            fontWeight: AppTextStyles.medium,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Form Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Email Field
                        CustomTextField(
                          label: 'Username',
                          hint: 'Johndoe',
                          icon: Icons.people,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        // Password Field
                        CustomTextField(
                          label: 'Password',
                          hint: '•••••••••',
                          icon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                        ),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomButton(
                            text: 'Forgot Password?',
                            variant: ButtonVariant.text,
                            size: ButtonSize.small,
                            fullWidth: false,
                            onPressed: () {
                              NavigationService.push('/forgot-password');
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Login Button
                        CustomButton(
                          text: 'Log In',
                          icon: Icons.arrow_forward,
                          onPressed: authState is AuthLoading
                              ? null
                              : _handleLogin,
                          isLoading: authState is AuthLoading,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        CustomButton(
                          text: 'Contact Admin',
                          variant: ButtonVariant.text,
                          size: ButtonSize.small,
                          fullWidth: false,
                          onPressed: () {
                            // Handle contact admin
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
