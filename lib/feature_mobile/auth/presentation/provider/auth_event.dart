import 'package:ams_mobile/feature_mobile/auth/domain/entities/change_password_entity.dart';
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

/// Event triggered when user attempts to change password
class ChangePasswordEvent extends AuthEvent {
  final ChangePasswordEntity changePasswordEntity;

  const ChangePasswordEvent({required this.changePasswordEntity});
}
