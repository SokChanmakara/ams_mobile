/// Base class for all profile events
sealed class ProfileEvent {
  const ProfileEvent();
}

/// Event to fetch user profile
class FetchProfileEvent extends ProfileEvent {
  const FetchProfileEvent();
}

/// Event to reset profile state
class ResetProfileEvent extends ProfileEvent {
  const ResetProfileEvent();
}
