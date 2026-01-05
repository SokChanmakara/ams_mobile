import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/data/model/login_response_data.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';

class LoginUseCase implements BaseUseCase<LoginResponseData, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<BaseResponse<LoginResponseData>> call(LoginParams params) async {
    final response = await authRepository.login(params.loginEntity);

    // If login is successful and we have data, save token and set auth header
    if (response.status.isSuccess && response.data != null) {
      final loginData = response.data!;

      // Save tokens to storage
      await StorageService.saveAccessToken(loginData.accessToken);
      await StorageService.saveRefreshToken(loginData.refreshToken);
      await StorageService.saveTokenExpiresAt(loginData.expiresAt);
      await StorageService.saveUserId(loginData.user.id);
      await StorageService.saveUserEmail(loginData.user.email);
      await StorageService.saveUserName(
        '${loginData.user.firstName} ${loginData.user.lastName}',
      );
      await StorageService.setAuthenticated(true);

      // Set auth token in HTTP headers
      HttpService.instance.setAuthToken(loginData.accessToken);
    }

    return response;
  }
}

class LoginParams {
  final LoginEntity loginEntity;

  LoginParams(this.loginEntity);
}
