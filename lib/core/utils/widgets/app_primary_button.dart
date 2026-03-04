import 'package:flutter/material.dart';

import '../constants.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'app_text_widget.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    this.backgroundColor,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.textStyle,
  });

  final Color? backgroundColor;
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color textColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.green1_900,
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.green1_500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        ),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : AppTextWidget(
                  text: text,
                  style: AppTextStyles.styleBold16.copyWith(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
