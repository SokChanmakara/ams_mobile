/// Base class for all auth states
sealed class AuthState {
  const AuthState();
}

/// Initial state when auth has not been attempted
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State when auth operation is in progress (login/logout)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State when login is successful
class LoginSuccess extends AuthState {
  final String? message;

  const LoginSuccess({this.message});
}

/// State when login fails
class LoginFailure extends AuthState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage});
}

/// State when logout is successful
class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

/// State when logout fails
class LogoutFailure extends AuthState {
  final String errorMessage;

  const LogoutFailure({required this.errorMessage});
}

/// State when user is authenticated
class Authenticated extends AuthState {
  const Authenticated();
}

/// State when user is not authenticated
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// State when change password is successful
class ChangePasswordSuccess extends AuthState {
  final String? message;

  const ChangePasswordSuccess({this.message});
}

/// State when change password fails
class ChangePasswordFailure extends AuthState {
  final String errorMessage;

  const ChangePasswordFailure({required this.errorMessage});
}

/// State when forgot password is successful
class ForgotPasswordSuccess extends AuthState {
  final String? message;

  const ForgotPasswordSuccess({this.message});
}

/// State when forgot password fails
class ForgotPasswordFailure extends AuthState {
  final String errorMessage;

  const ForgotPasswordFailure({required this.errorMessage});
}

/// State when OTP verification is successful
class VerifyOtpSuccess extends AuthState {
  final String? message;

  const VerifyOtpSuccess({this.message});
}

/// State when OTP verification fails
class VerifyOtpFailure extends AuthState {
  final String errorMessage;

  const VerifyOtpFailure({required this.errorMessage});
}
