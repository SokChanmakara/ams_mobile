import 'dart:io';
import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/utils/custom_buttons.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/entities/update_profile_entity.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_provider.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_state.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/edit_profile_page/edit_profile_header.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/edit_profile_page/image_picker_bottom_sheet.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/edit_profile_page/profile_form_section.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/widget/edit_profile_page/profile_picture_section.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _imagePicker = ImagePicker();

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
        _phoneController.text = profile.phone;
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

  /// Show image picker bottom sheet
  Future<void> _showImagePickerOptions() async {
    await ImagePickerBottomSheet.show(context, onSourceSelected: _pickImage);
  }

  /// Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      setState(() => _isLoading = true);

      final imageFile = File(pickedFile.path);
      final success = await ref
          .read(profileNotifierProvider.notifier)
          .uploadProfileImage(imageFile);

      setState(() => _isLoading = false);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture updated successfully!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Failed to update profile picture. Please try again.',
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
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
        // Navigator.of(context).pop();
        NavigationService.goBack();
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
    final profileState = ref.watch(profileNotifierProvider);

    // Show loading if profile is not loaded
    if (profileState is! ProfileLoaded) {
      return Scaffold(
        backgroundColor: AppColors.white,
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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const EditProfileHeader(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Picture Section
                    ProfilePictureSection(
                      imageUrl: profile.imageUrl,
                      fullName: profile.fullName,
                      isLoading: _isLoading,
                      onTap: _showImagePickerOptions,
                    ),

                    // Form sections
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Personal Information Form
                          ProfileFormSection(
                            firstNameController: _firstNameController,
                            lastNameController: _lastNameController,
                            phoneController: _phoneController,
                            emailController: _emailController,
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
}
