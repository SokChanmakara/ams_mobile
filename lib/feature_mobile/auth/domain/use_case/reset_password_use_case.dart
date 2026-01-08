import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/reset_password_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';

class ResetPasswordUseCase implements BaseUseCase<void, ResetPasswordParams> {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  @override
  Future<BaseResponse<void>> call(ResetPasswordParams params) async {
    final response = await authRepository.resetPassword(
      params.resetPasswordEntity,
    );

    // If reset password is successful, clear the reset token from storage
    if (response.status.isSuccess) {
      await StorageService.removeResetPasswordToken();
    }

    return response;
  }
}

class ResetPasswordParams {
  final ResetPasswordEntity resetPasswordEntity;

  ResetPasswordParams(this.resetPasswordEntity);
}
