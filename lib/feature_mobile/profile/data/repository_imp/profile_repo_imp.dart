import 'dart:io';
import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/feature_mobile/profile/data/model/user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRepoImp extends ProfileRepository {
  @override
  Future<BaseResponse<UserProfile>> getUserProfile() async {
    final response = await HttpService.instance.get(BaseUrl.userProfile);
    return BaseResponse<UserProfile>.fromJson(
      response.data,
      (json) => UserProfile.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<BaseResponse<String>> uploadProfileImage(File imageFile) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    final response = await HttpService.instance.uploadFile(
      BaseUrl.userProfile,
      formData: formData,
    );

    return BaseResponse<String>.fromJson(
      response.data,
      (json) => json as String,
    );
  }
}
