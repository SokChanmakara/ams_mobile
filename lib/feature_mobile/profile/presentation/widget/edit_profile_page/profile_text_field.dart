import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final bool enabled;
  final bool isFixed;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  const ProfileTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.isFixed = false,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final bool isReadOnly = isFixed || !enabled;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            // if (isFixed)
            //   Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            //     decoration: BoxDecoration(
            //       color: AppColors.surface(context),
            //       borderRadius: BorderRadius.circular(4),
            //       border: Border.all(color: AppColors.border(context)),
            //     ),
            //     child: Text(
            //       'FIXED',
            //       style: AppTextStyles.labelSmall(
            //         color: AppColors.textSecondary(context),
            //         fontWeight: AppTextStyles.semiBold,
            //       ),
            //     ),
            //   ),
          ],
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: enabled ? 1.0 : 0.7,
          child: Stack(
            children: [
              TextField(
                controller: controller,
                readOnly: isReadOnly,
                enabled: enabled,
                enableInteractiveSelection: false,
                contextMenuBuilder: (_, __) => const SizedBox.shrink(),
                keyboardType: keyboardType,
                style: AppTextStyles.bodyLarge(
                  color: enabled
                      ? AppColors.textPrimary(context)
                      : AppColors.textDisabled(context),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: enabled
                      ? AppColors.surface(context)
                      : AppColors.surfaceElevated(
                          context,
                        ).withValues(alpha: 0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.border(context)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.border(context)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.borderFocused,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: prefixIcon != null ? 40 : 12,
                    vertical: 14,
                  ),
                  hintText: hintText,
                ),
              ),
              if (prefixIcon != null)
                Positioned(
                  left: 12,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    prefixIcon,
                    color: AppColors.icon(context),
                    size: 20,
                  ),
                ),
              if (isFixed)
                Positioned(
                  right: 12,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.lock,
                    color: AppColors.icon(context),
                    size: 18,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
