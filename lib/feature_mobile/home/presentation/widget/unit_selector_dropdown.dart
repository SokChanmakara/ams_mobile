import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/feature_mobile/home/data/model/unit_model.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitSelectorDropdown extends ConsumerWidget {
  final List<UnitModel> units;
  final UnitModel? selectedUnit;

  const UnitSelectorDropdown({
    super.key,
    required this.units,
    this.selectedUnit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2936) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedUnit?.id,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDark ? Colors.grey[400] : const Color(0xFF4C739A),
            size: 20,
          ),
          dropdownColor: isDark ? const Color(0xFF1E2936) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          isDense: true,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : const Color(0xFF0D141B),
          ),
          items: units.map((unit) {
            return DropdownMenuItem<String>(
              value: unit.id,
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: unit.status == 'occupied'
                          ? Colors.green
                          : Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Unit ${unit.unitNumber}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF0D141B),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          unit.condominium.name,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? Colors.grey[400]
                                : const Color(0xFF4C739A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              final unit = units.firstWhere((u) => u.id == newValue);
              ref.read(unitNotifierProvider.notifier).selectUnit(unit);
            }
          },
          selectedItemBuilder: (BuildContext context) {
            return units.map<Widget>((unit) {
              final isSelected = unit.id == selectedUnit?.id;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home_rounded,
                    size: 16,
                    color: isDark
                        ? AppColors.primary.withValues(alpha: 0.8)
                        : AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Unit ${unit.unitNumber}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected
                                ? (isDark ? Colors.white : const Color(0xFF0D141B))
                                : Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
