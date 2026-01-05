import 'package:ams_mobile/core/models/base_response.dart';

/// Base use case with parameters
/// Type [T] - Return type wrapped in BaseResponse
/// Type [Params] - Parameters required for the use case
abstract class BaseUseCase<T, Params> {
  Future<BaseResponse<T>> call(Params params);
}

/// Base use case without parameters
/// Type [T] - Return type wrapped in BaseResponse
abstract class BaseUseCaseNoParams<T> {
  Future<BaseResponse<T>> call();
}
