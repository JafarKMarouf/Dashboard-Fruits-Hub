import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/styles/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';
import 'app_text_widget.dart';

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.text,
    this.widget,
    this.width,
    this.height,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.textStyle,
    this.colorShadow = AppColors.green1_900,
  });

  final Color? backgroundColor;
  final String? text;
  final void Function()? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color textColor;
  final TextStyle? textStyle;
  final Widget? widget;
  final Color colorShadow;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height ?? 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: widget.colorShadow,
              blurRadius: 4,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor ?? AppColors.green1_500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          ),
          onPressed: widget.onPressed,
          child:
              widget.widget ??
              Center(
                child: widget.isLoading
                    ? const CircularProgressIndicator()
                    : AppTextWidget(
                        widget.text!,
                        style: AppTextStyles.styleBold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
              ),
        ),
      ),
    );
  }
}
