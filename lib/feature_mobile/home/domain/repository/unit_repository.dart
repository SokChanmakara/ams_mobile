import 'package:ams_mobile/core/models/base_response.dart';
import 'package:ams_mobile/feature_mobile/home/data/model/unit_model.dart';

abstract class UnitRepository {
  Future<BaseResponse<List<UnitModel>>> getUserUnits();
}
