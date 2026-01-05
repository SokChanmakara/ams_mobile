import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';

class LoginUseCase implements BaseUseCase<void, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<BaseResponse<void>> call(LoginParams params) {
    return authRepository.login(params.loginEntity);
  }
}

class LoginParams {
  final LoginEntity loginEntity;

  LoginParams(this.loginEntity);
}
