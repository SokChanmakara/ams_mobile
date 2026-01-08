import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/feature_mobile/auth/data/model/login_response_data.dart';
import 'package:ams_mobile/feature_mobile/auth/data/model/refresh_token_response_data.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/change_password_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/login_entity.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/entities/verify_otp_entity.dart';

abstract class AuthRepository {
  Future<BaseResponse<LoginResponseData>> login(LoginEntity loginEntity);
  Future<BaseResponse> logout();
  Future<BaseResponse> changePassword(
    ChangePasswordEntity changePasswordEntity,
  );
  Future<BaseResponse<RefreshTokenResponseData>> refreshToken(
    String refreshToken,
  );
  Future<BaseResponse> forgotPassword(String email);
  Future<BaseResponse> verifyOtp(VerifyOtpEntity verifyOtpEntity);
}
