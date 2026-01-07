import 'dart:io';
import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/repository/profile_repository.dart';

class UploadProfileImageUseCase implements BaseUseCase<String, File> {
  final ProfileRepository profileRepository;

  UploadProfileImageUseCase(this.profileRepository);

  @override
  Future<BaseResponse<String>> call(File imageFile) async {
    return await profileRepository.uploadProfileImage(imageFile);
  }
}
