import 'package:flutter/material.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({
    super.key,
    required this.currentStep,
    this.stepsCount = 3,
  });

  final int currentStep;
  final int stepsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(stepsCount, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 10,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryDark : AppColors.borderLight,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }),
    );
  }
}
