import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';
import 'package:ams_mobile/core/models/base_response.dart' show Status;

class LogoutUseCase implements BaseUseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  @override
  Future<BaseResponse<void>> call(NoParams params) async {
    try {
      // Call API to logout
      await authRepository.logout();
    } catch (e) {
      // Log error but continue with local logout
      print('⚠️ Logout API call failed: $e');
    }

    // Clear local storage and remove auth header regardless of API response
    // This ensures user is logged out locally even if server call fails
    await StorageService.clearAuthData();
    HttpService.instance.removeAuthToken();

    // Always return success after clearing local data
    return BaseResponse<void>(
      status: Status(
        code: 200,
        message: 'Logged out successfully',
        isSuccess: true,
      ),
    );
  }
}

class NoParams {}
