import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/feature_mobile/profile/data/model/user_profile.dart';
import 'package:ams_mobile/feature_mobile/profile/domain/repository/profile_repository.dart';

class ProfileRepoImp extends ProfileRepository {
  @override
  Future<BaseResponse<UserProfile>> getUserProfile() async {
    final response = await HttpService.instance.get(BaseUrl.userProfile);
    return BaseResponse<UserProfile>.fromJson(
      response.data,
      (json) => UserProfile.fromJson(json as Map<String, dynamic>),
    );
  }
}
