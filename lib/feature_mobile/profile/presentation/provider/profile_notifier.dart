import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/use_case/get_user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_event.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_provider.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends Notifier<ProfileState> {
  late final GetUserProfileUseCase _getUserProfileUseCase;

  @override
  ProfileState build() {
    _getUserProfileUseCase = ref.read(getUserProfileUseCaseProvider);
    return const ProfileInitial();
  }

  /// Handle profile events
  Future<void> handleEvent(ProfileEvent event) async {
    switch (event) {
      case FetchProfileEvent():
        await _fetchProfile();
      case ResetProfileEvent():
        _resetProfile();
    }
  }

  /// Fetch user profile
  Future<void> _fetchProfile() async {
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

  /// Reset profile state
  void _resetProfile() {
    state = const ProfileInitial();
  }
}
