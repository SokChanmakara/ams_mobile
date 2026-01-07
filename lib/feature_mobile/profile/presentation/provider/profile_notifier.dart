import 'dart:io';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/use_case/get_user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/use_case/upload_profile_image.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_provider.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends Notifier<ProfileState> {
  late final GetUserProfileUseCase _getUserProfileUseCase;
  late final UploadProfileImageUseCase _uploadProfileImageUseCase;

  @override
  ProfileState build() {
    _getUserProfileUseCase = ref.read(getUserProfileUseCaseProvider);
    _uploadProfileImageUseCase = ref.read(uploadProfileImageUseCaseProvider);
    return const ProfileInitial();
  }

  /// Fetch user profile
  Future<void> fetchProfile() async {
    state = const ProfileLoading();

    try {
      final response = await _getUserProfileUseCase.call(NoParams());

      if (response.status.isSuccess && response.data != null) {
        state = ProfileLoaded(userProfile: response.data!);
      } else {
        // Check if it's an authentication error
        if (response.status.code == 401) {
          // Clear auth data and set unauthenticated state
          await StorageService.clearAuthData();
          HttpService.instance.removeAuthToken();
          state = ProfileUnauthenticated(
            errorMessage: 'Session expired. Please login again.',
          );
        } else {
          state = ProfileFailure(errorMessage: response.status.message);
        }
      }
    } catch (e) {
      // Check if it's a DioException with 401 status
      if (e is DioException && e.response?.statusCode == 401) {
        // Clear auth data and set unauthenticated state
        await StorageService.clearAuthData();
        HttpService.instance.removeAuthToken();
        state = const ProfileUnauthenticated(
          errorMessage: 'Session expired. Please login again.',
        );
      } else {
        state = ProfileFailure(errorMessage: e.toString());
      }
    }
  }

  /// Upload profile image
  Future<bool> uploadProfileImage(File imageFile) async {
    // Save current state to restore if upload fails
    final currentState = state;
    state = const ProfileLoading();

    try {
      final response = await _uploadProfileImageUseCase.call(imageFile);

      if (response.status.isSuccess) {
        // Refresh profile after successful upload
        await fetchProfile();
        return true;
      } else {
        // Restore previous state if upload fails
        state = currentState;
        return false;
      }
    } catch (e) {
      // Restore previous state on error
      state = currentState;
      return false;
    }
  }

  /// Reset profile state
  void resetProfile() {
    state = const ProfileInitial();
  }
}
