import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/feature_mobile/auth/data/model/verify_otp_response_data.dart';
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

  Future<BaseResponse<VerifyOtpResponseData>> call(
    VerifyOtpParams params,
  ) async {
    final response = await authRepository.verifyOtp(params.toEntity());

    // If OTP verification is successful and we have token data, save it
    if (response.status.isSuccess && response.data != null) {
      await StorageService.saveResetPasswordToken(response.data!.token);
    }

    return response;
  }
}
