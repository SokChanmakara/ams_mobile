import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/profile/data/model/user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/repository/profile_repository.dart';

class GetUserProfileUseCase implements BaseUseCase<UserProfile, NoParams> {
  final ProfileRepository profileRepository;

  GetUserProfileUseCase(this.profileRepository);

  @override
  Future<BaseResponse<UserProfile>> call(NoParams params) async {
    return await profileRepository.getUserProfile();
  }
}

class NoParams {}
