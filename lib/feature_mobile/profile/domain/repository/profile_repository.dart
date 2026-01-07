import 'dart:io';
import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/feature_mobile/profile/data/model/user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/entities/update_profile_entity.dart';

abstract class ProfileRepository {
  Future<BaseResponse<UserProfile>> getUserProfile();
  Future<BaseResponse<String>> uploadProfileImage(File imageFile);
  Future<BaseResponse<UserProfile>> updateUserProfile(
    UpdateProfileEntity entity,
  );
}
