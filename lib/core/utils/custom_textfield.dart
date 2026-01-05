import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart'; // Import your AppColors

/// A reusable custom text field with consistent styling and features
class CustomTextField extends StatefulWidget {
  /// The label text displayed above the field
  final String label;

  /// The hint text displayed inside the field
  final String hint;

  /// The icon displayed on the left side of the field
  final IconData icon;

  /// Controller for the text field
  final TextEditingController? controller;

  /// Whether this is a password field (shows/hides text)
  final bool isPassword;

  /// The keyboard type for the field
  final TextInputType? keyboardType;

  /// Callback when the text changes
  final ValueChanged<String>? onChanged;

  /// Callback when the field is submitted
  final ValueChanged<String>? onSubmitted;

  /// Validation function
  final String? Function(String?)? validator;

  /// Whether the field is enabled
  final bool enabled;

  /// Maximum number of lines (1 for single line)
  final int maxLines;

  /// Maximum length of text
  final int? maxLength;

  /// Custom suffix icon (overrides password visibility icon)
  final Widget? suffixIcon;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Text capitalization
  final TextCapitalization textCapitalization;

  /// Autofocus
  final bool autofocus;

  /// Focus node
  final FocusNode? focusNode;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Custom error text
  final String? errorText;

  /// Whether to show character counter
  final bool showCounter;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.suffixIcon,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.focusNode,
    this.textInputAction,
    this.errorText,
    this.showCounter = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;
  bool _isFocused = false;
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    } else {
      _internalFocusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary(context),
            ),
          ),
        ),

        // Text Field Container
        Container(
          height: widget.maxLines == 1 ? 56 : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _internalFocusNode,
            obscureText: widget.isPassword && !_isPasswordVisible,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            autofocus: widget.autofocus,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            validator: widget.validator,
            style: TextStyle(
              fontSize: 16,
              color: widget.enabled
                  ? AppColors.textPrimary(context)
                  : AppColors.textDisabled(context),
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              errorText: widget.errorText,
              hintStyle: TextStyle(color: AppColors.textTertiary(context)),

              // Prefix Icon
              prefixIcon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.icon,
                  color: _isFocused
                      ? AppColors.iconActive
                      : AppColors.icon(context),
                  size: 24,
                ),
              ),

              // Suffix Icon
              suffixIcon: _buildSuffixIcon(context),

              // Counter
              counterText: widget.showCounter ? null : '',

              // Styling
              filled: true,
              fillColor: widget.enabled
                  ? AppColors.surface(context)
                  : (AppColors.isDark(context)
                        ? AppColors.backgroundDark
                        : AppColors.shimmerBase(context)),

              // Borders
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.border(context)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.border(context)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.borderFocused,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.error, width: 2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.isDark(context)
                      ? AppColors.surfaceDark
                      : AppColors.border(context),
                ),
              ),

              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: widget.maxLines == 1 ? 0 : 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    // If custom suffix icon is provided, use it
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    // If password field, show visibility toggle
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _isPasswordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColors.icon(context),
          size: 24,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      );
    }

    return null;
  }
}
