import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_primary_button.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class StepButtons extends StatelessWidget {
  const StepButtons({
    super.key,
    required this.currentStep,
    required this.onNext,
    required this.onPrevious,
  });

  final int currentStep;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  bool get _isLastStep => currentStep == 2;
  bool get _isFirstStep => currentStep == 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!_isFirstStep) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: onPrevious,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const AppTextWidget('السابق'),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: AppPrimaryButton(
            onPressed: onNext,
            colorShadow: AppColors.borderLight,
            backgroundColor: AppColors.primaryDark,
            height: 56,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextWidget(
                  _isLastStep ? 'حفظ المنتج' : 'التالي',
                  style: AppTextStyles.styleBold16.copyWith(
                    color: Colors.white,
                  ),
                ),
                ?_isLastStep ? null : const SizedBox(width: 8),
                ?_isLastStep
                    ? null
                    : const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
