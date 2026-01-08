import 'package:ams_mobile/feature_mobile/home/data/model/unit_model.dart';

sealed class UnitState {}

class UnitInitial extends UnitState {}

class UnitLoading extends UnitState {}

class UnitLoaded extends UnitState {
  final List<UnitModel> units;
  final UnitModel? selectedUnit;

  UnitLoaded({required this.units, this.selectedUnit});

  UnitLoaded copyWith({List<UnitModel>? units, UnitModel? selectedUnit}) {
    return UnitLoaded(
      units: units ?? this.units,
      selectedUnit: selectedUnit ?? this.selectedUnit,
    );
  }
}

class UnitFailure extends UnitState {
  final String errorMessage;

  UnitFailure(this.errorMessage);
}
