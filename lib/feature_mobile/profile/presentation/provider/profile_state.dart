import 'package:ams_mobile/feature_mobile/profile/data/model/user_profile.dart';

/// Base class for all profile states
sealed class ProfileState {
  const ProfileState();
}

/// Initial state before any profile action
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// State when profile is being loaded
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// State when profile is successfully loaded
class ProfileLoaded extends ProfileState {
  final UserProfile userProfile;

  const ProfileLoaded({required this.userProfile});
}

/// State when profile loading fails
class ProfileFailure extends ProfileState {
  final String errorMessage;

  const ProfileFailure({required this.errorMessage});
}

/// State when user is unauthenticated (401 error)
class ProfileUnauthenticated extends ProfileState {
  final String errorMessage;

  const ProfileUnauthenticated({required this.errorMessage});
}
