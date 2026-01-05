import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';

/// Base class for all auth events
sealed class AuthEvent {
  const AuthEvent();
}

/// Event triggered when user attempts to login
class LoginEvent extends AuthEvent {
  final LoginEntity loginEntity;

  const LoginEvent({required this.loginEntity});
}

/// Event triggered when user attempts to logout
class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

/// Event triggered to reset auth state
class ResetAuthEvent extends AuthEvent {
  const ResetAuthEvent();
}
