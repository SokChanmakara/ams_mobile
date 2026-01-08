import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/edit_profile_page/profile_text_field.dart';
import 'package:flutter/material.dart';

class ProfileFormSection extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const ProfileFormSection({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'PERSONAL INFORMATION',
            style: AppTextStyles.labelSmall(
              color: AppColors.textSecondary(context),
              fontWeight: AppTextStyles.bold,
            ).copyWith(letterSpacing: 1.2),
          ),
        ),
        const SizedBox(height: 8),

        // Form Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow(context),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: AppColors.border(context), width: 1),
          ),
          child: Column(
            children: [
              ProfileTextField(
                label: 'First Name',
                isFixed: true,
                controller: firstNameController,
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Last Name',
                isFixed: true,
                controller: lastNameController,
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Phone Number',
                controller: phoneController,
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Email Address',
                controller: emailController,
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
