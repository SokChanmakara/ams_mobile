import 'package:ams_mobile/feature_mobile/home/data/repository_imp/unit_repo_imp.dart';
import 'package:ams_mobile/feature_mobile/home/domain/repository/unit_repository.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_notifier.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final unitRepositoryProvider = Provider<UnitRepository>((ref) {
  return UnitRepoImp();
});

final unitNotifierProvider = NotifierProvider<UnitNotifier, UnitState>(() {
  return UnitNotifier();
});
