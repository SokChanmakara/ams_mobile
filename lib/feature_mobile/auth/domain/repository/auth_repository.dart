import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/feature_mobile/auth/data/model/login_response_data.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<BaseResponse<LoginResponseData>> login(LoginEntity loginEntity);
  Future<BaseResponse> logout();
}
