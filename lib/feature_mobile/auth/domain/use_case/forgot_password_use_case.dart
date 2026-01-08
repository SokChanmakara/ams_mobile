import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';

class ForgotPasswordUseCase implements BaseUseCase<void, ForgotPasswordParams> {
  final AuthRepository authRepository;

  ForgotPasswordUseCase(this.authRepository);

  @override
  Future<BaseResponse<void>> call(ForgotPasswordParams params) async {
    return await authRepository.forgotPassword(params.email);
  }
}

class ForgotPasswordParams {
  final String email;

  ForgotPasswordParams(this.email);
}
