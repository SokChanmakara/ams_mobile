import 'package:ams_mobile/feature_mobile/auth/data/repository_imp/auth_repo_imp.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/use_case/login_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/use_case/logout_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_notifier.dart';
import 'package:ams_mobile/feature_mobile/auth/presentation/provider/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepoImp();
});

/// Provider for LoginUseCase
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginUseCase(authRepository);
});

/// Provider for LogoutUseCase
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(authRepository);
});

/// Provider for AuthNotifier
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
