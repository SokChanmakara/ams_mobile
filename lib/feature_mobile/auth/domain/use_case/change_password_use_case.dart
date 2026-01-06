import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/change_password_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';

class ChangePasswordUseCase implements BaseUseCase<void, ChangePasswordParams> {
  final AuthRepository authRepository;

  ChangePasswordUseCase(this.authRepository);

  @override
  Future<BaseResponse<void>> call(ChangePasswordParams params) async {
    return await authRepository.changePassword(params.changePasswordEntity);
  }
}

class ChangePasswordParams {
  final ChangePasswordEntity changePasswordEntity;

  ChangePasswordParams(this.changePasswordEntity);
}
