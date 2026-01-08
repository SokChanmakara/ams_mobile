import 'package:ams_mobile/feature_mobile/auth/domain/use_case/change_password_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/use_case/forgot_password_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/use_case/login_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/use_case/logout_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/use_case/verify_otp_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_event.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends Notifier<AuthState> {
  late final LoginUseCase _loginUseCase;
  late final LogoutUseCase _logoutUseCase;
  late final ChangePasswordUseCase _changePasswordUseCase;
  late final ForgotPasswordUseCase _forgotPasswordUseCase;
  late final VerifyOtpUseCase _verifyOtpUseCase;

  @override
  AuthState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    _logoutUseCase = ref.read(logoutUseCaseProvider);
    _changePasswordUseCase = ref.read(changePasswordUseCaseProvider);
    _forgotPasswordUseCase = ref.read(forgotPasswordUseCaseProvider);
    _verifyOtpUseCase = ref.read(verifyOtpUseCaseProvider);
    return const AuthInitial();
  }

  /// Handle auth events
  Future<void> handleEvent(AuthEvent event) async {
    switch (event) {
      case LoginEvent():
        await _handleLogin(event);
      case LogoutEvent():
        await _handleLogout();
      case ChangePasswordEvent():
        await _handleChangePassword(event);
      case ForgotPasswordEvent():
        await _handleForgotPassword(event);
      case VerifyOtpEvent():
        await _handleVerifyOtp(event);
      case ResetAuthEvent():
        _handleReset();
    }
  }

  /// Handle login event
  Future<void> _handleLogin(LoginEvent event) async {
    state = const AuthLoading();

    try {
      final response = await _loginUseCase.call(LoginParams(event.loginEntity));

      if (response.status.isSuccess) {
        state = LoginSuccess(message: response.status.message);
      } else {
        state = LoginFailure(errorMessage: response.status.message);
      }
    } catch (e) {
      // Provide user-friendly error message instead of technical details
      String errorMessage = 'Login failed. Please try again.';

      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 401:
            errorMessage = 'Invalid username or password.';
            break;
          case 404:
            errorMessage = 'Service not found. Please try again later.';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later.';
            break;
          default:
            if (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.sendTimeout ||
                e.type == DioExceptionType.receiveTimeout) {
              errorMessage = 'Connection timeout. Please check your internet.';
            } else if (e.type == DioExceptionType.connectionError) {
              errorMessage = 'No internet connection.';
            }
        }
      }

      state = LoginFailure(errorMessage: errorMessage);
    }
  }

  /// Handle logout event
  Future<void> _handleLogout() async {
    state = const AuthLoading();

    try {
      final response = await _logoutUseCase.call(NoParams());

      if (response.status.isSuccess) {
        state = const LogoutSuccess();
      } else {
        state = LogoutFailure(errorMessage: response.status.message);
      }
    } catch (e) {
      // Provide user-friendly error message
      String errorMessage = 'Logout failed. Please try again.';

      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          errorMessage = 'Connection timeout. Please check your internet.';
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = 'No internet connection.';
        }
      }

      state = LogoutFailure(errorMessage: errorMessage);
    }
  }

  /// Handle change password event
  Future<void> _handleChangePassword(ChangePasswordEvent event) async {
    state = const AuthLoading();

    try {
      final response = await _changePasswordUseCase.call(
        ChangePasswordParams(event.changePasswordEntity),
      );

      if (response.status.isSuccess) {
        state = ChangePasswordSuccess(message: response.status.message);
      } else {
        state = ChangePasswordFailure(errorMessage: response.status.message);
      }
    } catch (e) {
      // Provide user-friendly error message
      String errorMessage = 'Failed to change password. Please try again.';

      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 401:
            errorMessage = 'Current password is incorrect.';
            break;
          case 400:
            errorMessage = 'Invalid password format.';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later.';
            break;
          default:
            if (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.sendTimeout ||
                e.type == DioExceptionType.receiveTimeout) {
              errorMessage = 'Connection timeout. Please check your internet.';
            } else if (e.type == DioExceptionType.connectionError) {
              errorMessage = 'No internet connection.';
            }
        }
      }

      state = ChangePasswordFailure(errorMessage: errorMessage);
    }
  }

  /// Reset auth state to initial
  void _handleReset() {
    state = const AuthInitial();
  }

  /// Handle forgot password event
  Future<void> _handleForgotPassword(ForgotPasswordEvent event) async {
    state = const AuthLoading();

    try {
      final response = await _forgotPasswordUseCase.call(
        ForgotPasswordParams(event.email),
      );

      if (response.status.isSuccess) {
        state = ForgotPasswordSuccess(message: response.status.message);
      } else {
        state = ForgotPasswordFailure(errorMessage: response.status.message);
      }
    } catch (e) {
      // Provide user-friendly error message
      String errorMessage = 'Failed to send reset link. Please try again.';

      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 404:
            errorMessage = 'Email address not found.';
            break;
          case 400:
            errorMessage = 'Invalid email address.';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later.';
            break;
          default:
            if (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.sendTimeout ||
                e.type == DioExceptionType.receiveTimeout) {
              errorMessage = 'Connection timeout. Please check your internet.';
            } else if (e.type == DioExceptionType.connectionError) {
              errorMessage = 'No internet connection.';
            }
        }
      }

      state = ForgotPasswordFailure(errorMessage: errorMessage);
    }
  }

  /// Handle verify OTP event
  Future<void> _handleVerifyOtp(VerifyOtpEvent event) async {
    state = const AuthLoading();

    try {
      final response = await _verifyOtpUseCase.call(
        VerifyOtpParams(event.email, event.otp),
      );

      if (response.status.isSuccess) {
        state = VerifyOtpSuccess(message: response.status.message);
      } else {
        state = VerifyOtpFailure(errorMessage: response.status.message);
      }
    } catch (e) {
      // Provide user-friendly error message
      String errorMessage = 'Failed to verify OTP. Please try again.';

      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 400:
            errorMessage = 'Invalid or expired OTP code.';
            break;
          case 404:
            errorMessage = 'Verification session not found.';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later.';
            break;
          default:
            if (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.sendTimeout ||
                e.type == DioExceptionType.receiveTimeout) {
              errorMessage = 'Connection timeout. Please check your internet.';
            } else if (e.type == DioExceptionType.connectionError) {
              errorMessage = 'No internet connection.';
            }
        }
      }

      state = VerifyOtpFailure(errorMessage: errorMessage);
    }
  }
}
