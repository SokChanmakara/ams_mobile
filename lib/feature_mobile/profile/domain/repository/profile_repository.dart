import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/feature_mobile/profile/data/model/user_profile.dart';

abstract class ProfileRepository {
  Future<BaseResponse<UserProfile>> getUserProfile();
}
