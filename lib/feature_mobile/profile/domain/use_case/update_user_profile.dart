import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/profile/data/model/user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/entities/update_profile_entity.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/repository/profile_repository.dart';

class UpdateUserProfileUseCase
    implements BaseUseCase<UserProfile, UpdateProfileEntity> {
  final ProfileRepository profileRepository;

  UpdateUserProfileUseCase(this.profileRepository);

  @override
  Future<BaseResponse<UserProfile>> call(UpdateProfileEntity entity) async {
    return await profileRepository.updateUserProfile(entity);
  }
}
