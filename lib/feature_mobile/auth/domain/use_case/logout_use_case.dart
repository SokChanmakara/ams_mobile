import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/core/use_case/base_use_case.dart';
import 'package:ams_mobile/feature_mobile/auth/domain/repository/auth_repository.dart';

class LogoutUseCase implements BaseUseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  @override
  Future<BaseResponse<void>> call(NoParams params) async {
    // Call API to logout
    final response = await authRepository.logout();

    // Clear local storage and remove auth header regardless of API response
    await StorageService.clearAuthData();
    HttpService.instance.removeAuthToken();

    return response;
  }
}

class NoParams {}
