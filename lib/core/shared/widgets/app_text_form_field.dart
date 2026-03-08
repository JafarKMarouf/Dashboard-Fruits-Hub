import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/l10n.dart';
import '../../utils/styles/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.textInputType,
    this.textInputAction,
    this.validator,
    this.inputFormatters,
    this.showShadow = true,
    this.onSaved,
    this.label,
    this.suffixText,
    this.fillColor,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool obscureText;
  final Widget? suffixIcon, prefixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool showShadow;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final Color? fillColor;
  final int maxLines;

  InputBorder _buildBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color ?? Colors.transparent, width: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          AppTextWidget(
            label!,
            style: AppTextStyles.styleBold14.copyWith(
              color: AppColors.grayscale800,
            ),
          ),
        if (label != null) const SizedBox(height: 8),
        Container(
          decoration: showShadow
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                      spreadRadius: 0,
                    ),
                  ],
                )
              : null,
          child: TextFormField(
            validator:
                validator ??
                (value) => (value == null || value.isEmpty)
                    ? AppLocalizations.of(context).requiredField
                    : null,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            onSaved: onSaved,
            controller: controller,
            obscureText: obscureText,
            keyboardType: textInputType,
            textInputAction: textInputAction ?? TextInputAction.done,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.white,
              hintText: hintText,
              suffixIcon: suffixIcon,
              suffix: suffixText != null
                  ? AppTextWidget(
                      suffixText!,
                      style: AppTextStyles.styleRegular13.copyWith(
                        color: AppColors.grayscale400,
                      ),
                    )
                  : null,
              prefixIcon: prefixIcon,
              prefixIconColor: AppColors.grayscale400,
              hintStyle: AppTextStyles.styleSemiBold16.copyWith(
                color: AppColors.grayscale600,
              ),
              border: _buildBorder(),
              enabledBorder: _buildBorder(),
              focusedBorder: _buildBorder(AppColors.border),
              errorBorder: _buildBorder(AppColors.error),
              focusedErrorBorder: _buildBorder(AppColors.error),
              errorStyle: AppTextStyles.styleBold13.copyWith(
                color: AppColors.error,
              ),
            ),
            style: AppTextStyles.styleSemiBold16.copyWith(
              color: AppColors.grayscale600,
            ),
          ),
        ),
      ],
    );
  }
}
