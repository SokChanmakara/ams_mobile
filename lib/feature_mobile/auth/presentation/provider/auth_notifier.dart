import 'package:ams_mobile/feature_mobile/auth/domain/use_case/login_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_event.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_provider.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends Notifier<AuthState> {
  late final LoginUseCase _loginUseCase;

  @override
  AuthState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    return const AuthInitial();
  }

  /// Handle auth events
  Future<void> handleEvent(AuthEvent event) async {
    switch (event) {
      case LoginEvent():
        await _handleLogin(event);
      case LogoutEvent():
        await _handleLogout();
      case ResetAuthEvent():
        _handleReset();
    }
  }

  /// Handle login event
  Future<void> _handleLogin(LoginEvent event) async {
    state = const AuthLoading();

    try {
      final response = await _loginUseCase.call(
        LoginParams(event.loginEntity),
      );

      if (response.status.isSuccess) {
        state = LoginSuccess(message: response.status.message);
      } else {
        state = LoginFailure(errorMessage: response.status.message);
      }
    } catch (e) {
      state = LoginFailure(errorMessage: e.toString());
    }
  }

  /// Handle logout event
  Future<void> _handleLogout() async {
    state = const AuthLoading();

    try {
      // Add your logout logic here when you have logout use case
      await Future.delayed(const Duration(seconds: 1));
      state = const LogoutSuccess();
    } catch (e) {
      state = LogoutFailure(errorMessage: e.toString());
    }
  }

  /// Reset auth state to initial
  void _handleReset() {
    state = const AuthInitial();
  }
}
