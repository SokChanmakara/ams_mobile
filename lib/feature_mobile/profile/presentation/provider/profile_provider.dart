import 'package:ams_mobile/feature_mobile/profile/data/repository_imp/profile_repo_imp.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/repository/profile_repository.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/use_case/get_user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_notifier.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Profile repository provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepoImp();
});

/// Get user profile use case provider
final getUserProfileUseCaseProvider = Provider<GetUserProfileUseCase>((ref) {
  final repository = ref.read(profileRepositoryProvider);
  return GetUserProfileUseCase(repository);
});

/// Profile notifier provider
final profileNotifierProvider = NotifierProvider<ProfileNotifier, ProfileState>(
  ProfileNotifier.new,
);
