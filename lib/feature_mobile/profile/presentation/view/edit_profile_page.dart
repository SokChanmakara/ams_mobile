import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/entities/update_profile_entity.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_provider.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_state.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() =>
      _EditResidentProfilePageState();
}

class _EditResidentProfilePageState extends ConsumerState<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Store initial values to track changes
  String _initialFirstName = '';
  String _initialLastName = '';
  String _initialPhone = '';
  String _initialEmail = '';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize with profile data after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProfileData();
    });
  }

  void _initializeProfileData() {
    final profileState = ref.read(profileNotifierProvider);
    if (profileState is ProfileLoaded) {
      final profile = profileState.userProfile;

      // Split full name into first and last name
      final nameParts = profile.fullName.split(' ');
      final firstName = nameParts.isNotEmpty ? nameParts.first : '';
      final lastName = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : '';

      setState(() {
        _initialFirstName = firstName;
        _initialLastName = lastName;
        _initialEmail = profile.email;
        _initialPhone = profile.phone;

        _firstNameController.text = firstName;
        _lastNameController.text = lastName;
        _emailController.text = profile.email;
        _phoneController.text = profile.phone; // Phone not available
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Get only the changed fields
  UpdateProfileEntity _getChangedFields() {
    return UpdateProfileEntity(
      firstName: _firstNameController.text != _initialFirstName
          ? _firstNameController.text.trim()
          : null,
      lastName: _lastNameController.text != _initialLastName
          ? _lastNameController.text.trim()
          : null,
      email: _emailController.text != _initialEmail
          ? _emailController.text.trim()
          : null,
      phone: _phoneController.text != _initialPhone
          ? _phoneController.text.trim()
          : null,
    );
  }

  Future<void> _handleSaveChanges() async {
    final updates = _getChangedFields();

    if (!updates.hasUpdates) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No changes to save'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final success = await ref
        .read(profileNotifierProvider.notifier)
        .updateProfile(updates);

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        // Update initial values after successful save
        _initialFirstName = _firstNameController.text;
        _initialLastName = _lastNameController.text;
        _initialEmail = _emailController.text;
        _initialPhone = _phoneController.text;

        // Go back to profile page
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile. Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final profileState = ref.watch(profileNotifierProvider);

    // Show loading if profile is not loaded
    if (profileState is! ProfileLoaded) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Header with back button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background(context).withValues(alpha: 0.8),
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.divider(context),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Back',
                        style: AppTextStyles.bodyLarge(
                          color: AppColors.textSecondary(context),
                          fontWeight: AppTextStyles.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      );
    }

    final profile = profileState.userProfile;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.background(context).withValues(alpha: 0.8),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.divider(context),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 64,
                    child: TextButton(
                      onPressed: () => NavigationService.goBack(),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.bodyLarge(
                          color: AppColors.textSecondary(context),
                          fontWeight: AppTextStyles.medium,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Edit Profile',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineSmall(
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 64),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Picture Section
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primaryLight,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: 112,
                                  height: 112,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.background(context),
                                      width: 4,
                                    ),
                                    image: profile.imageUrl.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              profile.imageUrl,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    color: profile.imageUrl.isEmpty
                                        ? AppColors.primary
                                        : null,
                                  ),
                                  child: profile.imageUrl.isEmpty
                                      ? Center(
                                          child: Text(
                                            profile.fullName.isNotEmpty
                                                ? profile.fullName[0]
                                                      .toUpperCase()
                                                : 'U',
                                            style: const TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.surface(context),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    // Form sections
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Personal Information
                          _buildSectionHeader('PERSONAL INFORMATION', isDark),
                          const SizedBox(height: 8),

                          _buildCard(
                            isDark,
                            children: [
                              _buildTextField(
                                label: 'First Name',
                                controller: _firstNameController,
                                isDark: isDark,
                                prefixIcon: Icons.person_outline,
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                label: 'Last Name',
                                controller: _lastNameController,
                                isDark: isDark,
                                prefixIcon: Icons.person_outline,
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                label: 'Phone Number',
                                controller: _phoneController,
                                isDark: isDark,
                                prefixIcon: Icons.phone,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                label: 'Email Address',
                                controller: _emailController,
                                isDark: isDark,
                                prefixIcon: Icons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Save Button
                          CustomButton(
                            text: 'Save Changes',
                            icon: Icons.check,
                            iconAtEnd: false,
                            size: ButtonSize.medium,
                            isLoading: _isLoading,
                            onPressed: _isLoading ? null : _handleSaveChanges,
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: AppTextStyles.labelSmall(
          color: AppColors.textSecondary(context),
          fontWeight: AppTextStyles.bold,
        ).copyWith(letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildCard(
    bool isDark, {
    required List<Widget> children,
    EdgeInsets? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    String? value,
    required bool isDark,
    bool enabled = true,
    bool isFixed = false,
    IconData? prefixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            if (isFixed)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.border(context)),
                ),
                child: Text(
                  'FIXED',
                  style: AppTextStyles.labelSmall(
                    color: AppColors.textSecondary(context),
                    fontWeight: AppTextStyles.semiBold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: enabled ? 1.0 : 0.7,
          child: Stack(
            children: [
              TextField(
                controller: controller,
                enabled: enabled,
                keyboardType: keyboardType,
                style: AppTextStyles.bodyLarge(
                  color: enabled
                      ? AppColors.textPrimary(context)
                      : AppColors.textDisabled(context),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: enabled
                      ? AppColors.surface(context)
                      : AppColors.surfaceElevated(
                          context,
                        ).withValues(alpha: 0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.border(context)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.border(context)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.borderFocused,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: prefixIcon != null ? 40 : 12,
                    vertical: 14,
                  ),
                  hintText: value,
                ),
              ),
              if (prefixIcon != null)
                Positioned(
                  left: 12,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    prefixIcon,
                    color: AppColors.icon(context),
                    size: 20,
                  ),
                ),
              if (isFixed)
                Positioned(
                  right: 12,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.lock,
                    color: AppColors.icon(context),
                    size: 18,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
