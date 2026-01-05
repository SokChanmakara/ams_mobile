import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<BaseResponse> login(LoginEntity loginEntity);
  Future<BaseResponse> logout();
}
