import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'SELECT PROPERTY',
            style: AppTextStyles.labelMedium(
              color: AppColors.textSecondary(context),
              fontWeight: AppTextStyles.semiBold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border(context), width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedUnit?.id,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isDark ? AppColors.icon(context) : AppColors.primary,
                size: 24,
              ),
              dropdownColor: AppColors.surface(context),
              borderRadius: BorderRadius.circular(12),
              isDense: false,
              style: AppTextStyles.titleMedium(
                color: AppColors.textPrimary(context),
                fontWeight: AppTextStyles.semiBold,
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
                              ? AppColors.success
                              : AppColors.warning,
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
                              style: AppTextStyles.titleSmall(
                                color: AppColors.textPrimary(context),
                                fontWeight: AppTextStyles.semiBold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              unit.condominium.name,
                              style: AppTextStyles.labelSmall(
                                color: AppColors.textTertiary(context),
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
                      Flexible(
                        child: Text(
                          'Unit ${unit.unitNumber} • ${unit.condominium.name}',
                          style: AppTextStyles.titleMedium(
                            color: isSelected
                                ? AppColors.textPrimary(context)
                                : AppColors.textTertiary(context),
                            fontWeight: AppTextStyles.semiBold,
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
        ),
      ],
    );
  }
}
