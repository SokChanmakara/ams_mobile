import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/verify_otp_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';

class VerifyOtpParams {
  final String email;
  final String otp;

  VerifyOtpParams(this.email, this.otp);

  VerifyOtpEntity toEntity() {
    return VerifyOtpEntity(email: email, otp: otp);
  }
}

class VerifyOtpUseCase {
  final AuthRepository authRepository;

  VerifyOtpUseCase(this.authRepository);

  Future<BaseResponse> call(VerifyOtpParams params) async {
    return await authRepository.verifyOtp(params.toEntity());
  }
}
