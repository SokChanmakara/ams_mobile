import 'package:ams_mobile/core/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';

enum ButtonVariant { primary, secondary, outline, text }

enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool iconAtEnd;
  final bool isLoading;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.iconAtEnd = true,
    this.isLoading = false,
    this.fullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return Container(
      height: _getHeight(),
      width: fullWidth ? double.infinity : null,
      decoration: _shouldShowShadow()
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(
                borderRadius ?? _getBorderRadius(),
              ),
              boxShadow: isEnabled
                  ? [
                      BoxShadow(
                        color: (backgroundColor ?? AppColors.primary)
                            .withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            )
          : null,
      child: _buildButton(context, isEnabled),
    );
  }

  Widget _buildButton(BuildContext context, bool isEnabled) {
    switch (variant) {
      case ButtonVariant.primary:
        return _buildPrimaryButton(context, isEnabled);
      case ButtonVariant.secondary:
        return _buildSecondaryButton(context, isEnabled);
      case ButtonVariant.outline:
        return _buildOutlineButton(context, isEnabled);
      case ButtonVariant.text:
        return _buildTextButton(context, isEnabled);
    }
  }

  Widget _buildPrimaryButton(BuildContext context, bool isEnabled) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: textColor ?? AppColors.white,
        disabledBackgroundColor: (backgroundColor ?? AppColors.primary)
            .withValues(alpha: 0.5),
        disabledForegroundColor: (textColor ?? AppColors.white).withValues(
          alpha: 0.5,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getBorderRadius(),
          ),
        ),
        padding: _getPadding(),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, bool isEnabled) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? AppColors.primary.withValues(alpha: 0.1),
        foregroundColor: textColor ?? AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.05),
        disabledForegroundColor: AppColors.primary.withValues(alpha: 0.5),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getBorderRadius(),
          ),
        ),
        padding: _getPadding(),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildOutlineButton(BuildContext context, bool isEnabled) {
    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary,
        disabledForegroundColor: AppColors.primary.withValues(alpha: 0.5),
        side: BorderSide(
          color: isEnabled
              ? (backgroundColor ?? AppColors.primary)
              : AppColors.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getBorderRadius(),
          ),
        ),
        padding: _getPadding(),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildTextButton(BuildContext context, bool isEnabled) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary,
        disabledForegroundColor: AppColors.primary.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? _getBorderRadius(),
          ),
        ),
        padding: _getPadding(),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == ButtonVariant.primary
                ? (textColor ?? AppColors.white)
                : (textColor ?? AppColors.primary),
          ),
        ),
      );
    }

    final textWidget = Text(
      text,
      style: TextStyle(fontSize: _getFontSize(), fontWeight: FontWeight.bold),
    );

    if (icon == null) {
      return textWidget;
    }

    final iconWidget = Icon(icon, size: _getIconSize());

    return Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconAtEnd
          ? [textWidget, const SizedBox(width: 8), iconWidget]
          : [iconWidget, const SizedBox(width: 8), textWidget],
    );
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return 44;
      case ButtonSize.medium:
        return 56;
      case ButtonSize.large:
        return 64;
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return 14;
      case ButtonSize.medium:
        return 16;
      case ButtonSize.large:
        return 18;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 18;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 22;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case ButtonSize.small:
        return 10;
      case ButtonSize.medium:
        return 12;
      case ButtonSize.large:
        return 14;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  bool _shouldShowShadow() {
    return variant == ButtonVariant.primary;
  }
}

class ResourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ResourceButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.border(context).withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 15,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: AppColors.primary),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyMedium(
                  color: AppColors.textPrimary(context),
                  fontWeight: AppTextStyles.semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomPaymentButton extends StatelessWidget {
  final double amount;
  final int selectedCount;
  final bool isEnabled;

  const BottomPaymentButton({
    super.key,
    required this.amount,
    this.selectedCount = 0,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasAmount = amount > 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.fromLTRB(
        20.w,
        hasAmount ? 20.h : 12.h,
        20.w,
        hasAmount ? 20.h : 12.h,
      ),
      decoration: BoxDecoration(
        color: hasAmount
            ? AppColors.surface(context).withValues(alpha: 0.9)
            : AppColors.surface(context).withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(
            color: hasAmount
                ? AppColors.border(context)
                : AppColors.border(context).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Payment Button
            ElevatedButton(
              onPressed: isEnabled && hasAmount
                  ? () {
                      NavigationService.push('/payments');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: hasAmount ? AppColors.primary : Colors.grey,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
                disabledForegroundColor: Colors.grey.withValues(alpha: 0.5),
                padding: EdgeInsets.symmetric(
                  vertical: hasAmount ? 16.h : 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: hasAmount ? 4 : 0,
                shadowColor: hasAmount
                    ? const Color(0xFF002B5B).withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedCount > 0
                        ? 'Pay \$${amount.toStringAsFixed(2)} ($selectedCount ${selectedCount == 1 ? 'Invoice' : 'Invoices'})'
                        : hasAmount
                        ? 'Pay \$${amount.toStringAsFixed(2)} Now'
                        : 'Select invoices to pay',
                    style: AppTextStyles.buttonLarge(
                      color: hasAmount
                          ? Colors.white
                          : Colors.grey.withValues(alpha: 0.7),
                      fontWeight: AppTextStyles.semiBold,
                    ),
                  ),
                  if (hasAmount) ...[
                    SizedBox(width: 8.w),
                    Icon(Icons.arrow_forward, size: 20.sp),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
