import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';

class AuthRepoImp extends AuthRepository {
  @override
  Future<BaseResponse> login(LoginEntity loginEntity) async {
    final response = await HttpService.instance.post(
      BaseUrl.login,
      data: loginEntity.toJson(),
    );
    return BaseResponse.fromJson(response.data, null);
  }

  @override
  Future<BaseResponse> logout() async {
    final response = await HttpService.instance.post(BaseUrl.logout);
    return BaseResponse.fromJson(response.data, null);
  }
}
