import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/core/service/base_url.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/feature_mobile/home/data/model/unit_model.dart';
import 'package:ams_mobile/feature_mobile/home/domain/repository/unit_repository.dart';

class UnitRepoImp extends UnitRepository {
  @override
  Future<BaseResponse<List<UnitModel>>> getUserUnits() async {
    final response = await HttpService.instance.get(BaseUrl.userUnits);
    return BaseResponse<List<UnitModel>>.fromJson(response.data, (json) {
      if (json is List) {
        return json
            .map((item) => UnitModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    });
  }
}
