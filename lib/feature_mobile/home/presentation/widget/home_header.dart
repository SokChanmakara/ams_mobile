import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:ams_mobile/core/widgets/image_loader.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_provider.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/provider/unit_state.dart';
import 'package:ams_mobile/feature_mobile/home/presentation/widget/unit_selector_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final String name;
  final String? imageUrl;
  final UnitState unitState;

  const HomeHeader({
    super.key,
    required this.name,
    this.imageUrl,
    required this.unitState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: AppColors.shadowMedium)],
        // border: Border(
        //   bottom: BorderSide(color: AppColors.divider(context), width: 0.5),
        // ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Picture with Online Status
              Stack(
                children: [
                  ImageLoader(
                    imageUrl: imageUrl.toString(),
                    width: 40,
                    height: 40,
                    radius: BorderRadius.circular(99),
                  ),

                  // Container(
                  //   width: 40,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     border: Border.all(
                  //       color: AppColors.border(context),
                  //       width: 2,
                  //     ),
                  //     image: imageUrl != null
                  //         ? DecorationImage(
                  //             image: NetworkImage(imageUrl!),
                  //             fit: BoxFit.cover,
                  //           )
                  //         : null,
                  //     color: imageUrl == null
                  //         ? AppColors.surface(context)
                  //         : null,
                  //   ),
                  //   child: imageUrl == null
                  //       ? Icon(
                  //           Icons.person,
                  //           color: AppColors.icon(context),
                  //           size: 24,
                  //         )
                  //       : null,
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.background(context),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.h5(
                        color: AppColors.textPrimary(context),
                        fontWeight: AppTextStyles.bold,
                      ),
                    ),
                    Text(
                      unitState is UnitLoaded &&
                              (unitState as UnitLoaded).selectedUnit != null
                          ? 'Unit ${(unitState as UnitLoaded).selectedUnit!.unitNumber}'
                          : 'No unit selected',
                      style: AppTextStyles.bodySmall(
                        color: AppColors.textSecondary(context),
                        fontWeight: AppTextStyles.medium,
                      ),
                    ),
                  ],
                ),
              ),
              // Notification Button
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surface(context),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowMedium,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: AppColors.textPrimary(context),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surface(context),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Unit Selector Dropdown
          const SizedBox(height: 16),
          if (unitState is UnitLoading)
            Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            )
          else if (unitState is UnitLoaded)
            (unitState as UnitLoaded).units.isNotEmpty
                ? UnitSelectorDropdown(
                    units: (unitState as UnitLoaded).units,
                    selectedUnit: (unitState as UnitLoaded).selectedUnit,
                  )
                : const SizedBox.shrink()
          else if (unitState is UnitFailure)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: AppColors.error, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Failed to load units',
                      style: AppTextStyles.bodySmall(color: AppColors.error),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(unitNotifierProvider.notifier).fetchUnits();
                    },
                    child: Text(
                      'Retry',
                      style: AppTextStyles.bodySmall(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
