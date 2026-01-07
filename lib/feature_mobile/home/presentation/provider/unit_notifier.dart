import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/feature_mobile/home/data/model/unit_model.dart';
import 'package:ams_mobile/feature_mobile/home/domain/repository/unit_repository.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_provider.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitNotifier extends Notifier<UnitState> {
  late final UnitRepository _repository;
  static const String _selectedUnitKey = 'selected_unit_id';

  @override
  UnitState build() {
    // Initialize repository from provider
    _repository = ref.read(unitRepositoryProvider);
    return UnitInitial();
  }

  Future<void> fetchUnits() async {
    state = UnitLoading();
    try {
      final response = await _repository.getUserUnits();

      if (response.status.isSuccess && response.data != null) {
        final units = response.data!;

        // Try to load previously selected unit
        final savedUnitId = StorageService.instance.getString(_selectedUnitKey);
        UnitModel? selectedUnit;

        if (savedUnitId != null) {
          try {
            selectedUnit = units.firstWhere(
              (unit) => unit.id == savedUnitId,
            );
          } catch (e) {
            selectedUnit = units.isNotEmpty ? units.first : null;
          }
        } else if (units.isNotEmpty) {
          selectedUnit = units.first;
        }

        state = UnitLoaded(units: units, selectedUnit: selectedUnit);

        // Save the selected unit
        if (selectedUnit != null) {
          await StorageService.instance.setString(_selectedUnitKey, selectedUnit.id);
        }
      } else {
        state = UnitFailure(response.status.message);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Failed to fetch units';
      state = UnitFailure(errorMessage);
    } catch (e) {
      state = UnitFailure('An unexpected error occurred');
    }
  }

  Future<void> selectUnit(UnitModel unit) async {
    if (state is UnitLoaded) {
      final currentState = state as UnitLoaded;
      state = currentState.copyWith(selectedUnit: unit);
      await StorageService.instance.setString(_selectedUnitKey, unit.id);
    }
  }

  UnitModel? get selectedUnit {
    if (state is UnitLoaded) {
      return (state as UnitLoaded).selectedUnit;
    }
    return null;
  }
}
