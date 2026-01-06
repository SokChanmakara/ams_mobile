import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/feature_mobile/auth/data/model/login_response_data.dart';
import 'package:ams_mobile/feature_mobile/auth/data/model/refresh_token_response_data.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/change_password_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepoImp extends AuthRepository {
  @override
  Future<BaseResponse<LoginResponseData>> login(LoginEntity loginEntity) async {
    final response = await HttpService.instance.post(
      BaseUrl.login,
      data: loginEntity.toJson(),
    );
    return BaseResponse<LoginResponseData>.fromJson(
      response.data,
      (json) => LoginResponseData.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<BaseResponse> logout() async {
    // Send logout request without Authorization header
    // This prevents issues with invalid/expired tokens during logout
    final response = await HttpService.instance.post(
      BaseUrl.logout,
      options: Options(
        headers: {'Authorization': null}, // Explicitly remove auth header
      ),
    );
    return BaseResponse.fromJson(response.data, null);
  }

  @override
  Future<BaseResponse> changePassword(
    ChangePasswordEntity changePasswordEntity,
  ) async {
    final response = await HttpService.instance.post(
      BaseUrl.changePassword,
      data: changePasswordEntity.toJson(),
    );
    return BaseResponse.fromJson(response.data, null);
  }

  @override
  Future<BaseResponse<RefreshTokenResponseData>> refreshToken(
    String refreshToken,
  ) async {
    final response = await HttpService.instance.post(
      BaseUrl.refreshToken,
      data: {'refreshToken': refreshToken},
    );
    return BaseResponse<RefreshTokenResponseData>.fromJson(
      response.data,
      (json) => RefreshTokenResponseData.fromJson(json as Map<String, dynamic>),
    );
  }
}
